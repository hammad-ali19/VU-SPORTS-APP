from flask import redirect, render_template, url_for, request, flash
from flask_login import current_user, login_required
from sqlalchemy import select, or_
from datetime import date
from .. import db
from ..decorators import required_role
from ..models import *
from . import p_bp


@p_bp.route("/")
def redirect_login():
    return redirect(url_for("participant.dashboard"))


@p_bp.route("/dashboard")
@login_required
@required_role(userRole.PARTICIPANT)
def dashboard():
    ps = current_user.participant.sports
    return render_template("participant/dashboard.html", sports=ps)


@p_bp.route("/announcements")
@login_required
@required_role(userRole.PARTICIPANT)
def announcements():
    announcements = db.session.execute(
        select(Announcement)
        .join(AnnouncementRecipient)
        .where(AnnouncementRecipient.recipient_id == current_user.id)
        .order_by(Announcement.created_at.desc())
    ).scalars().all()
    return render_template('participant/announcements.html', announcements=announcements)


@p_bp.route("/my-profile", methods=['POST', 'GET'])
@login_required
@required_role(userRole.PARTICIPANT)
def manage_profile():
    if request.method == 'POST':
        user = current_user
        participant = user.participant

        # Always update name (required field)
        user.name = request.form.get('name')

        # Optional fields (only update if not empty)
        university_id = request.form.get('university_id')
        if university_id:
            participant.university_id = university_id

        achievements = request.form.get('achievements')
        if achievements and achievements.strip():
            participant.achievements = achievements

        past_participation = request.form.get('past_participation')
        if past_participation and past_participation.strip():
            participant.past_participation = past_participation

        db.session.commit()
        flash('Profile updated successfully!', 'success')

        return redirect(url_for('participant.manage_profile'))

    return render_template("participant/my_profile.html")

@p_bp.route("/team-members/<int:team_id>", methods=['POST'])
def team_members(team_id):
    team = db.session.get(Team, team_id)
    print(team.members)
    return render_template('participant/team_members.html', team=team)

@p_bp.route("/scheduled-events", methods=['GET'])
def scheduled_events():
    today = date.today()
    participant = current_user.participant
    # participant sports ids
    sport_ids = [ps.sport_id for ps in participant.sports]
    # REGISTERED EVENTS
    registered_events = (
        db.session.scalars(
            select(EventRegistration)
            .join(Event)
            .where(
                EventRegistration.participant_id == participant.id,
                # Event.end_date >= today
            )
            .order_by(Event.start_date.asc())
        ).all()
    )
    # ids of already registered events
    registered_event_ids = [er.event_id for er in registered_events]
    # ONGOING EVENTS
    ongoing_events = (
        db.session.scalars(
            select(Event)
            .where(
                Event.sport_id.in_(sport_ids),
                Event.start_date <= today,
                Event.end_date >= today,
                ~Event.id.in_(registered_event_ids)
            )
            .order_by(Event.start_date.asc())
        ).all()
    )
    # UPCOMING EVENTS
    upcoming_events = (
        db.session.scalars(
            select(Event)
            .where(
                Event.sport_id.in_(sport_ids),
                Event.start_date > today,
                ~Event.id.in_(registered_event_ids)
            )
            .order_by(Event.start_date.asc())
        ).all()
    )

    past_events = (
        db.session.scalars(
            select(Event)
            .where(
                Event.sport_id.in_(sport_ids),
                Event.end_date < today
            )
            .order_by(Event.start_date.asc())
        ).all()
    )

    return render_template(
        "participant/scheduled_events.html",
        ongoing_events=ongoing_events,
        upcoming_events=upcoming_events,
        registered_events=registered_events,
        past_events=past_events,
        today=today
    )


@p_bp.route("scheduled-events/register-for-event/<int:event_id>/<int:sport_id>", methods=['POST', 'GET'])
def register_for_event(event_id, sport_id):
    event_id = int(request.form.get('event_id'))
    print(f"this is {current_user.participant.events}")
    event = db.session.get(Event, event_id)
    par_reg_events = current_user.participant.events
    status = db.session.execute(select(ParticipantSport.status).where(ParticipantSport.participant_id==current_user.participant.id, ParticipantSport.sport_id == sport_id)).scalar()
    print(f"participant id: {current_user.participant.id} event id: {event_id} and sport id: {sport_id} status: {status}")
    print(status)
    if not par_reg_events:
        if status == 'active':
            event_reg = EventRegistration(participant_id=current_user.participant.id, event_id=event_id)
            db.session.add(event_reg)
            db.session.commit()
            flash(f"You will be notified when admin approves you request for {event.name}", category="success")
            return redirect(url_for("participant.scheduled_events"))
        else:
            flash("You cannot participate in events of sports you are not approved for", category='info')
            return redirect(url_for("participant.scheduled_events"))
    else:
        for pre in par_reg_events:
            if pre.event_id == event_id:
                print(pre.event_id, event_id)
                flash('you are already registered for this event', category="info")
                return redirect(url_for("participant.scheduled_events"))
        

    if status == 'active':
        event_reg = EventRegistration(participant_id=current_user.participant.id, event_id=event_id)
        db.session.add(event_reg)
        db.session.commit()
        flash(f"You will be notified when admin approves you request for {event.name}", category="success")
        return redirect(url_for("participant.scheduled_events"))
    else:
        flash("You cannot participate in events of sports you are not approved for", category='info')
        return redirect(url_for("participant.scheduled_events"))


# @p_bp.route('/chat/<int:user_id>')
# @login_required
# def chat(user_id):
#     messages = Message.query.filter(
#         ((Message.sender_id == current_user.id) & (Message.receiver_id == user_id)) |
#         ((Message.sender_id == user_id) & (Message.receiver_id == current_user.id))
#     ).order_by(Message.timestamp).all()

#     return render_template("chat.html", messages=messages, other_user_id=user_id)


@p_bp.route("teams")
@login_required
@required_role(userRole.PARTICIPANT)
def teams():
    participant = current_user.participant
    par_sports = participant.sports
    print(par_sports)
    teams = []
    for ps in par_sports:
        teams.append(ps.sport.teams)
    teams = [item for sublist in teams for item in sublist]
    # teams = db.session.execute(select(Team)).scalars().all()
    print(teams)
    return render_template('participant/available_teams.html',teams=teams)



@p_bp.route('/join-team/<int:team_id>', methods=['POST'])
@login_required
def join_team(team_id):
    participant = current_user.participant
    team = Team.query.get_or_404(team_id)

    existing = TeamParticipant.query.filter_by(
        team_id=team.id,
        participant_id=participant.id
    ).first()

    if existing:
        flash("You are already in this team.", "warning")
        return redirect(url_for('participant.teams'))

    if len(team.members) >= team.max_participants:
        flash("Team is full.", "danger")
        return redirect(url_for('participant.teams'))

    if not team.approved:
        flash("This team is not approved yet.", "warning")
        return redirect(url_for('participant.teams'))

    already_in_same_sport = any(
        tp.team.sport_id == team.sport_id
        for tp in participant.teams
    )

    if already_in_same_sport:
        flash("You already joined a team for this sport.", "warning")
        return redirect(url_for('participant.teams'))


    tp = TeamParticipant(
        team_id=team.id,
        participant_id=participant.id
    )
    db.session.add(tp)
    db.session.commit()

    flash("Successfully joined the team!", "success")
    return redirect(url_for('participant.teams'))


@p_bp.route('/leave_team/<int:team_id>', methods=['POST'])
def leave_team(team_id):
    participant = current_user.participant
    tm = db.session.execute(select(TeamParticipant).where(TeamParticipant.participant_id == participant.id and TeamParticipant.team_id == team_id)).scalar()
    flash(f"You have successfully been removed from {tm.team.name}.", category='success')
    db.session.delete(tm)
    db.session.commit()
    return redirect(url_for('participant.dashboard'))


@p_bp.route("/event_details/<int:event_id>", methods=['POST', 'GET'])
def event_details(event_id):
    event = Event.query.get_or_404(event_id)

    matches = (
        Match.query
        .filter(Match.event_id == event_id)
        .order_by(Match.date_time.asc())
        .all()
    )

    team_statuses = (
        EventTeamStatus.query
        .filter(EventTeamStatus.event_id == event_id)
        .all()
    )
    print(f"team_statuses: {team_statuses}")
    grouped_status = {}

    for status in team_statuses:
        phase = status.team_phase_in_event
        if phase not in grouped_status:
            grouped_status[phase] = []
        grouped_status[phase].append(status)
    print(f"grouped_status: {grouped_status}")
    return render_template("participant/event_details.html", event=event, matches=matches, grouped_status=grouped_status)

@p_bp.route('/single-history')
def participant_single_history():
    participant_id = current_user.participant.id
    # Get all past single-player matches of participant
    print(f"participant: {current_user.participant}")
    matches = (
        db.session.query(Match)
        .join(Event, Match.event_id == Event.id)
        .join(
            EventRegistration,
            EventRegistration.event_id == Event.id
        )
        .filter(
            Match.match_type == 'single',
            # Event.end_date >= date.today(),
            EventRegistration.participant_id == participant_id,
            EventRegistration.approved == True,

            or_(
                Match.player1_id == participant_id,
                Match.player2_id == participant_id
            )
        )
        .order_by(Event.end_date.desc(), Match.date_time.asc())
        .all()
    )
    print(f"matches: {matches}")
    # Group matches event-wise
    events_data = {}
    for match in matches:
        event = match.event
        if event.id not in events_data:
            events_data[event.id] = {
                "event": event,
                "matches": [],
                "result": None
            }
        events_data[event.id]["matches"].append(match)
    # Determine participant result in each event
    for data in events_data.values():
        event_matches = data["matches"]
        # latest played match in tournament
        latest_match = event_matches[-1]
        won_latest = (latest_match.winner_participant_id == participant_id)

        stage = latest_match.match_stage.lower()

        if won_latest:
            if stage == "final":
                result = "Champion"
            else:
                result = f"Won {latest_match.match_stage}"
        else:
            if stage == "final":
                result = "Runner-up"
            else:
                result = f"Reached {latest_match.match_stage}"

        data["result"] = result
    print(f"events data: {events_data}")
    return render_template('participant/participant_single_history.html', events_data=events_data.values())