from flask import abort, flash, redirect, render_template, session, url_for, request
from flask_login import login_required
from sqlalchemy import select

from .. import db
from ..decorators import required_role
from ..models import Sport, User, userRole, userStatus
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
def approve(user_id):
    user = db.session.get(User, user_id)
    if user is None:
        abort(404)
    user.status = userStatus.ACTIVE
    db.session.commit()
    print(user.status)
    return redirect(url_for("admin.dashboard"))


@a_bp.route("/reject_user")
def reject_user():
    pass


@a_bp.route("/manage-participants")
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
def manage_coaches():
    coaches = (
        db.session.execute(select(User).where(User.role == userRole.COACH))
        .scalars()
        .all()
    )
    return render_template("admin/manage_coaches.html", coaches=coaches)


@a_bp.route("/manage-sports")
def manage_sports():
    sports = db.session.execute(select(Sport)).scalars().all()
    return render_template("admin/manage_sports.html", sports=sports)


@a_bp.route("/event-scheduling")
def manage_event_scheduling():
    return render_template("admin/event_scheduling.html")



@a_bp.route("/add_user", methods=['POST'])
def add_participant():
    if "from_admin" not in session:
        session["from_admin"] = 1

    return redirect(url_for("auth.register"))


@a_bp.route("/delete-user", methods=['POST'])
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