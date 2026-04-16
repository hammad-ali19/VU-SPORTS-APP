from . import c_bp
from .. import db
from sqlalchemy import select
from flask import render_template, session, url_for, redirect, request, flash
from flask_login import login_required, current_user
from ..decorators import required_role
from ..models import *

@c_bp.route("/")
def redirect_login():
	return redirect(url_for("coach.dashboard"))

@c_bp.route("/dashboard")
@login_required
@required_role(userRole.COACH)
def dashboard():
	sport = db.session.execute(select(Sport).where(current_user.coach.id == Sport.coach_id)).scalars().first()
	print(type(sport.participants))
	print(sport.participants[0].participant.user.name)
	# sport = session.get('coach-sport')
	# participants = db.session.execute(select(Participant).where())
	return render_template("coach/dashboard.html", sport=sport, participants=sport.participants)


@c_bp.route("/my-profile", methods=['POST', 'GET'])
@login_required
@required_role(userRole.COACH)
def my_profile():
    if request.method == 'POST':
        user = current_user
        coach = user.coach

        # Always update name
        user.name = request.form.get('name')

        # Availability (always update since it's controlled input)
        availability = request.form.get('availability')
        if availability == 'true':
            coach.availability = True
        else:
            coach.availability = False

        # Expertise (only update if not empty)
        expertise = request.form.get('expertise')
        if expertise and expertise.strip():
            coach.expertise = expertise

        db.session.commit()
        flash('Profile updated successfully!', 'success')

        return redirect(url_for('coach.my_profile'))
    return render_template("coach/my_profile.html")

@c_bp.route("/manage-participants")
@login_required
@required_role(userRole.COACH)
def manage_participants():
	return render_template("coach/manage_participants.html")


@c_bp.route("/approve/<int:ps_id>", methods=['POST'])
@login_required
@required_role(userRole.COACH)
def approve(ps_id):

	ps = db.session.get(ParticipantSport, ps_id)
	if ps.status != 'active':
		ps.status = 'active'
		ps.approved_by = ps.sport.coach.id
		db.session.commit()
		# db.session.refresh(current_user)
	return redirect(url_for("coach.dashboard"))

@c_bp.route("/teams")
@login_required
@required_role(userRole.COACH)
def teams():
    sport = db.session.execute(select(Sport).where(current_user.coach.id == Sport.coach_id)).scalars().first()
    teams = db.session.execute(select(Team).where(Team.sport_id == sport.id)).scalars().all()
    print(teams)
    return render_template("coach/teams.html", teams=teams, sport=sport)

@c_bp.route("/announcements", methods=['GET', 'POST'])
@login_required
@required_role(userRole.COACH)
def announcements():
    sport = db.session.execute(select(Sport).where(current_user.coach.id == Sport.coach_id)).scalars().first()
    teams = current_user.coach.teams
    announcements = db.session.execute(select(Announcement).where(Announcement.sender_id == current_user.id).order_by(Announcement.created_at.desc())).scalars().all()

    if request.method == 'POST':
        title = request.form.get('title', '').strip()
        body = request.form.get('body', '').strip()
        target = request.form.get('target')

        if not title or not body or not target:
            flash('Please fill in all announcement fields.', 'danger')
            return redirect(url_for('coach.announcements'))

        # announcement = Announcement(title=title, body=body, sender_id=current_user.id)
        # db.session.add(announcement)

        recipients = []
        if target == 'sport':
            if not sport:
                flash('You do not have a sport assigned yet.', 'danger')
                return redirect(url_for('coach.announcements'))
            recipients = [ps.participant.user for ps in sport.participants if ps.status == 'active']
        elif target == 'team':
            team_id = request.form.get('team_id')
            # if not team_id or not team_id.isdigit():
            #     flash('Please select a team.', 'danger')
            #     return redirect(url_for('coach.announcements'))
            team = db.session.get(Team, int(team_id))
            # if not team or team.coach_id != current_user.coach.id:
            #     flash('Invalid team selected.', 'danger')
            #     return redirect(url_for('coach.announcements'))
            recipients = [member.participant.user for member in team.members]
        else:
            flash('Invalid announcement target.', 'danger')
            return redirect(url_for('coach.announcements'))

        if not recipients:
            flash('No recipients were found for this announcement.', 'danger')
            return redirect(url_for('coach.announcements'))

        announcement = Announcement(title=title, body=body, sender_id=current_user.id)
        db.session.add(announcement)

        for recipient in recipients:
            announcement.recipients.append(AnnouncementRecipient(recipient_id=recipient.id))

        db.session.commit()
        flash('Announcement sent successfully.', 'success')
        return redirect(url_for('coach.announcements'))

    return render_template('coach/announcements.html', sport=sport, teams=teams, announcements=announcements)

@c_bp.route("/view-announcements")
@login_required
@required_role(userRole.COACH)
def view_announcements():
    announcements = db.session.execute(
        select(Announcement)
        .join(AnnouncementRecipient)
        .where(AnnouncementRecipient.recipient_id == current_user.id)
        .order_by(Announcement.created_at.desc())
    ).scalars().all()
    return render_template('coach/view_announcements.html', announcements=announcements)

@c_bp.route("/create-team", methods=['GET', 'POST'])
@login_required
@required_role(userRole.COACH)
def create_team():
    from flask import request, flash
    sport = db.session.execute(select(Sport).where(current_user.coach.id == Sport.coach_id)).scalars().first()
    if request.method == 'POST':
        name = request.form.get('name')
        max_participants = request.form.get('max_participants')
        if name and max_participants:
            team = Team(name=name, max_participants=int(max_participants), sport_id=sport.id, coach_id=current_user.coach.id)
            db.session.add(team)
            db.session.commit()
            flash("Team created successfully!", "success")
            return redirect(url_for("coach.teams"))
        else:
            flash("Please fill all fields.", "danger")
    return render_template("coach/create_team.html", sport=sport)

@c_bp.route("/team-details/<int:team_id>")
@login_required
@required_role(userRole.COACH)
def team_details(team_id):
    print(team_id)
    team = db.session.get(Team, team_id)
    teams = team.coach.sport.teams
    print(teams)
    if not team or team.coach_id != current_user.coach.id:
        return "Unauthorized", 403
    # Get approved participants for the sport
    already_joined = []
    for t in teams:
        for member in t.members:
            already_joined.append(member.participant)
    # print(already_joined)

    approved_ps = db.session.execute(select(ParticipantSport).where(ParticipantSport.sport_id == team.sport_id, ParticipantSport.status == 'active')).scalars().all()
    # available_participants = [ps.participant for ps in approved_ps if not any(tp.participant_id == ps.participant_id for tp in team.members)]
    # available_participants = [ps.participant for ps in approved_ps if not any(aj.id == ps.participant.id for aj in already_joined)]

    available_participants = []
    for ps in approved_ps:
        if ps.participant not in already_joined:
            available_participants.append(ps.participant)
    
    return render_template("coach/team_details.html", team=team, available_participants=available_participants)

@c_bp.route("/add-to-team/<int:team_id>", methods=['POST'])
@login_required
@required_role(userRole.COACH)
def add_to_team(team_id):
    team = db.session.get(Team, team_id)
    if not team or team.coach_id != current_user.coach.id:
        return "Unauthorized", 403
    participant_id = request.form.get('participant_id')
    if not participant_id:
        flash("Please select a participant.", "danger")
        return redirect(url_for("coach.team_details", team_id=team_id))
    participant_id = int(participant_id)
    if len(team.members) >= team.max_participants:
        flash("Team is full.", "danger")
        return redirect(url_for("coach.team_details", team_id=team_id))
    # Check if participant is approved for the sport
    ps = db.session.execute(select(ParticipantSport).where(ParticipantSport.participant_id == participant_id, ParticipantSport.sport_id == team.sport_id, ParticipantSport.status == 'active')).scalars().first()
    if not ps:
        flash("Participant not approved for this sport.", "danger")
        return redirect(url_for("coach.team_details", team_id=team_id))
    # Check if already in team
    existing = db.session.execute(select(TeamParticipant).where(TeamParticipant.team_id == team_id, TeamParticipant.participant_id == participant_id)).scalars().first()
    if existing:
        flash("Participant already in team.", "danger")
        return redirect(url_for("coach.team_details", team_id=team_id))
    tp = TeamParticipant(team_id=team_id, participant_id=participant_id)
    db.session.add(tp)
    db.session.commit()
    flash("Participant added to team.", "success")
    return redirect(url_for("coach.team_details", team_id=team_id))

@c_bp.route("/remove-from-team/<int:team_id>/<int:participant_id>", methods=['POST'])
@login_required
@required_role(userRole.COACH)
def remove_from_team(team_id, participant_id):
    team = db.session.get(Team, team_id)
    if not team or team.coach_id != current_user.coach.id:
        return "Unauthorized", 403
    tp = db.session.execute(select(TeamParticipant).where(TeamParticipant.team_id == team_id, TeamParticipant.participant_id == participant_id)).scalars().first()
    if tp:
        db.session.delete(tp)
        db.session.commit()
        flash("Participant removed from team.", "success")
    return redirect(url_for("coach.team_details", team_id=team_id))


@c_bp.route("/disable-participant/<int:ps_id>", methods=['POST'])
@login_required
@required_role(userRole.COACH)
def disable(ps_id):
    ps = db.session.get(ParticipantSport, ps_id)
    ps.status = 'pending'
    db.session.commit()
    return redirect(url_for('coach.dashboard'))

@c_bp.route("/events")
def events():
    coach = current_user.coach
    events = coach.sport.events
    return render_template("coach/events.html", events=events)


@c_bp.route('/event/<int:event_id>/participants')
@login_required
def event_participants(event_id):
    event = db.get_or_404(Event, event_id)
    # event = Event.query.get_or_404(event_id)
    return render_template('coach/event_participants.html', event=event)