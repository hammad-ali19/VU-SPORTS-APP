from . import c_bp
from .. import db
from sqlalchemy import select
from flask import render_template, session, url_for, redirect
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