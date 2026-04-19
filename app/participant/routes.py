from flask import redirect, render_template, url_for, request, flash
from flask_login import current_user, login_required
from sqlalchemy import select
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
    from datetime import datetime
    from sqlalchemy import select

    # 1. Get the current time
    now = datetime.now()

    # 2. Build the query
    stmt = select(Event).where(Event.date_time >= now).order_by(Event.date_time.asc())

    # 3. Execute (assuming 'db.session' if using Flask-SQLAlchemy)
    upcoming_events = db.session.scalars(stmt).all()
    # print(upcoming_events)



    participant_sports = current_user.participant.sports
    sports = []
    for ps in participant_sports:
        sports.append(ps.sport)
    events = []
    for s in sports:
        events.append(s.events)
    # print(sports)
    # print(events)
    all_events = []
    for event_array in events:
        for event in event_array:
            if event.date_time >= datetime.now():
                all_events.append(event)
    registered_events = []
    for er in current_user.participant.events:
        if er.event.date_time >= datetime.now():
            registered_events.append(er.event)
    print(registered_events)
    # print(type(sports[0]))
    # print((all_events))
    
    return render_template("participant/scheduled_events.html", events=all_events, registered_events=registered_events)
#     return {
#     "sports": [{"id": s.id, "name": s.name} for s in sports],
#     "events": [{"id": e.id, "name": e.name} for e in all_events]
# }

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
            flash(f"you have been registerd for event: {event.name}", category="success")
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
        flash(f"you have been registerd for event: {event.name}", category="success")
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