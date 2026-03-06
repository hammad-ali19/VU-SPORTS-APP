from flask import render_template, jsonify, redirect, url_for
from sqlalchemy import select

from .. import  db
from . import a_bp
from flask_login import login_required, current_user
from ..decorators import required_role
from ..models import *



@a_bp.route("/")
def redirect_login():
	return redirect(url_for("admin.dashboard"))

@a_bp.route("/dashboard")
@login_required
@required_role(userRole.ADMIN)
def dashboard():
	participants = db.session.execute(select(User).where(User.role == 'PARTICIPANT')).scalars().all()
	coaches = db.session.execute(select(User).where(User.role == 'COACH')).scalars().all()
	sports = db.session.execute(select(Sport)).scalars().all()
	users = db.session.execute(select(User).where(User.role != 'ADMIN')).scalars().all()

	return render_template('admin/admin-dashboard.html',
						participants=participants,
						coaches=coaches,
						sports=sports,
						users=users)


@a_bp.route("/get_pending_coach_requests")
@login_required
@required_role(userRole.ADMIN)
def get_pending_coach_requests():
	pending_coaches = db.session.execute(select(User).where(User.status=='PENDING')).scalars().all()
	data = [
		{
			"name": c.name,
			"email": c.email,
			"status": c.status.value,
			"sport": c.coach.sport.name
		}
		for c in pending_coaches
	]
	return jsonify(data)

@a_bp.route("/test")
def test_url():
	print("testing testing testing")
	return 'this is a testing url request came from js button'


@a_bp.route('/approve/<int:user_id>', methods=['POST', 'GET'])
def approve(user_id):
	user = db.session.get(User, user_id)
	user.status = 'active'
	db.session.commit()
	print(user.status)
	# users = db.session.execute(select(User)).scalars().all()
	# participants = db.session.execute(select(User).where(User.role == 'PARTICIPANT')).scalars().all()
	# coaches = db.session.execute(select(User).where(User.role == 'COACH')).scalars().all()
	# sports = db.session.execute(select(Sport)).scalars().all()
	# return redirect(url_for('admin.dashboard',
	# 					participants=participants,
	# 					coaches=coaches,
	# 					sports=sports,
	# 					users=users))
	return redirect(url_for('admin.dashboard'))

@a_bp.route('/reject_user')
def reject_user():
	pass


@a_bp.route("/manage-participants")
def manage_participants():
	return render_template("admin/manage_participants.html")

@a_bp.route("/manage-coaches")
def manage_coaches():
	return render_template("admin/manage_coaches.html")

@a_bp.route("/manage-sports")
def manage_sports():
	return render_template("admin/manage_sports.html")

@a_bp.route("/event-scheduling")
def manage_event_scheduling():
	return render_template("admin/event_scheduling.html")