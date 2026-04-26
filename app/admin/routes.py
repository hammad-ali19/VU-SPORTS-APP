from flask import abort, flash, redirect, render_template, session, url_for, request
from flask_login import login_required, current_user
from sqlalchemy import select

from .. import db
from ..decorators import required_role
from ..models import *
from . import a_bp


@a_bp.route("/")
def redirect_login():
    return redirect(url_for("admin.dashboard"))


@a_bp.route("/dashboard")
@login_required
@required_role(userRole.ADMIN)
def dashboard():
    participants = (
        db.session.execute(select(User).where(User.role == userRole.PARTICIPANT))
        .scalars()
        .all()
    )
    coaches = (
        db.session.execute(select(User).where(User.role == userRole.COACH)).scalars().all()
    )
    sports = db.session.execute(select(Sport)).scalars().all()
    users = db.session.execute(select(User).where(User.role != userRole.ADMIN)).scalars().all()

    return render_template(
        "admin/admin-dashboard.html",
        participants=participants,
        coaches=coaches,
        sports=sports,
        users=users,
    )


@a_bp.route("/approve/<int:user_id>", methods=["POST", "GET"])
@login_required
@required_role(userRole.ADMIN)
def approve(user_id):
    user = db.session.get(User, user_id)
    if user is None:
        abort(404)
    user.status = userStatus.ACTIVE
    db.session.commit()
    print(user.status)
    return redirect(url_for("admin.dashboard"))


@a_bp.route("/reject_user", methods=['POST'])
@login_required
@required_role(userRole.ADMIN)
def reject_user():
    return 'Nothing here yet!'

@a_bp.route("/block_user/<int:user_id>", methods=['POST', 'GET'])
@login_required
@required_role(userRole.ADMIN)
def block_user(user_id):
    user = db.session.get(User, user_id)
    if user is None:
        abort(404)
    user.status = userStatus.BLOCKED
    db.session.commit()
    print(user.status)
    return redirect(url_for("admin.dashboard"))


@a_bp.route("/manage-participants")
@login_required
@required_role(userRole.ADMIN)
def manage_participants():
    # print(f"after entering manage_participatns {str(session.items())}")

    # print(f"after setting manage_participatns {str(session.items())}")
    participants = (
        db.session.execute(select(User).where(User.role == userRole.PARTICIPANT))
        .scalars()
        .all()
    )
    return render_template("admin/manage_participants.html", participants=participants)


@a_bp.route("/manage-coaches")
@login_required
@required_role(userRole.ADMIN)
def manage_coaches():
    coaches = (
        db.session.execute(select(User).where(User.role == userRole.COACH))
        .scalars()
        .all()
    )
    return render_template("admin/manage_coaches.html", coaches=coaches)


@a_bp.route("/manage-sports", methods=['POST', 'GET'])
@login_required
@required_role(userRole.ADMIN)
def manage_sports():
    sports = db.session.execute(select(Sport)).scalars().all()
    return render_template("admin/manage_sports.html", sports=sports)


@a_bp.route("/event-scheduling")
@login_required
@required_role(userRole.ADMIN)
def manage_event_scheduling():
    venues = db.session.execute(select(Venue)).scalars().all()
    sports = db.session.execute(select(Sport)).scalars().all()
    events = db.session.execute(select(Event)).scalars().all()
    return render_template("admin/event_scheduling.html", venues=venues, sports=sports, events=events)

@a_bp.route("/announcements", methods=['GET', 'POST'])
@login_required
@required_role(userRole.ADMIN)
def announcements():
    coaches = db.session.execute(select(User).where(User.role == userRole.COACH)).scalars().all()
    participants = db.session.execute(select(User).where(User.role == userRole.PARTICIPANT)).scalars().all()
    announcements = db.session.execute(select(Announcement).order_by(Announcement.created_at.desc())).scalars().all()

    if request.method == 'POST':
        rids = request.form.getlist('recipient_ids')
        print(rids)
        title = request.form.get('title', '').strip()
        body = request.form.get('body', '').strip()
        target = request.form.get('target')

        if not title or not body or not target:
            flash('Please fill in all announcement fields.', category='danger')
            return redirect(url_for('admin.announcements'))

        announcement = Announcement(title=title, body=body, sender_id=current_user.id)
        db.session.add(announcement)

        recipients = []
        if target == 'all':
            recipients = db.session.execute(select(User).where(User.role != userRole.ADMIN)).scalars().all()
        elif target == 'coaches':
            selected = [int(uid) for uid in request.form.getlist('recipient_ids') if uid.isdigit()]
            recipients = db.session.execute(select(User).where(User.role == userRole.COACH, User.id.in_(selected))).scalars().all()
        elif target == 'participants':
            selected = [int(uid) for uid in request.form.getlist('recipient_ids') if uid.isdigit()]
            recipients = db.session.execute(select(User).where(User.role == userRole.PARTICIPANT, User.id.in_(selected))).scalars().all()
        else:
            flash('Invalid announcement target.', category='danger')
            return redirect(url_for('admin.announcements'))

        if target in ['coaches', 'participants'] and not recipients:
            flash('Please select at least one recipient for the chosen target.', category='danger')
            return redirect(url_for('admin.announcements'))

        for recipient in recipients:
            announcement.recipients.append(AnnouncementRecipient(recipient_id=recipient.id))

        db.session.commit()
        flash('Announcement sent successfully.', category='success')
        return redirect(url_for('admin.announcements'))

    return render_template('admin/announcements.html', coaches=coaches, participants=participants, announcements=announcements)

@a_bp.route("/view-announcements")
@login_required
@required_role(userRole.ADMIN)
def view_announcements():
    announcements = db.session.execute(select(Announcement).join(Announcement.sender).where(User.role == userRole.COACH)).scalars().all()
    return render_template('admin/view_announcements.html', announcements=announcements)

@a_bp.route("/add-event", methods=['POST'])
@login_required
@required_role(userRole.ADMIN)
def add_event():
    date = request.form.get('date')
    time = request.form.get('time')
    date_time = date + " " + time
    name = request.form.get('name')
    venue_id = request.form.get('venue_id')
    sport_id = request.form.get('sport_id')
    print(date_time)
    e = db.session.execute(select(Event).where(Event.date_time==date_time)).scalars().first()
    if e:
        flash("Event on this Date and Time already exists!", category='error')
        return redirect(url_for("admin.manage_event_scheduling"))

    else:
        event = Event(name=name, date_time=date_time, sport_id=sport_id, venue_id=venue_id)
        db.session.add(event)
        db.session.commit()
        flash("Event added successfully!", category='success')
        return redirect(url_for("admin.manage_event_scheduling"))


@a_bp.route("/add-venue", methods=['POST'])
@login_required
@required_role(userRole.ADMIN)
def add_venue():
    venues = db.session.execute(select(Venue.location)).scalars().all()
    venues = [venue.lower() for venue in venues]
    new_venue_name = request.form.get('name').lower()
    availability = request.form.get("availability")
    # return f"availability: {bool(int(availability))}"
    if new_venue_name in venues:
        flash("This venue already exists", category='error')
        return redirect(url_for("admin.manage_event_scheduling"))
    else:
        venue = Venue(location=new_venue_name, availability=bool(int(availability)))
        db.session.add(venue)
        db.session.commit()
        flash("Venue Added successfully", category='success')
        return redirect(url_for("admin.manage_event_scheduling"))
        



@a_bp.route("/add_user", methods=['POST'])
@login_required
@required_role(userRole.ADMIN)
def add_user():
    # if "from_admin" not in session:
    #     session["from_admin"] = 1
    return redirect(url_for("auth.register"))


@a_bp.route("/delete-user", methods=['POST'])
@login_required
@required_role(userRole.ADMIN)
def delete_user():
    u_id = request.args.get("u_id")
    if u_id:
        user = db.session.get(User, u_id)
        if user:
            email = user.email
            db.session.delete(user)
            db.session.commit()
            flash(f"User with email: {email} is deleted successfully", category='success')
            return redirect(url_for('admin.dashboard'))
    return "Not found"

@a_bp.route("/delete-event/<int:event_id>",methods=['POST'])
@login_required
@required_role(userRole.ADMIN)
def delete_event(event_id):
    e = db.session.get(Event, int(event_id))
    db.session.delete(e)
    db.session.commit()
    flash("Event deleted successfully", category='success')
    return redirect(url_for('admin.manage_event_scheduling'))


@a_bp.route("/teams-management")
@login_required
@required_role(userRole.ADMIN)
def teams_management():
    teams = db.session.execute(select(Team)).scalars().all()
    print(type(teams))
    print(teams)
    for t in teams:
        print(t.name)
    return render_template("admin/teams-management.html", teams=teams)


@a_bp.route('/approve-team/<int:team_id>', methods=['POST'])
@login_required
@required_role(userRole.ADMIN)
def approve_team(team_id):
    team = Team.query.get_or_404(team_id)
    team.approved = True
    db.session.commit()
    return redirect(url_for('admin.teams_management'))
