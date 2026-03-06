from . import p_bp
from flask import redirect, render_template, request, session, url_for
from flask_login import login_required, current_user
from ..decorators import required_role
from ..models import userRole

@p_bp.route("/")
def redirect_login():
	return redirect(url_for("participant.dashboard"))

@p_bp.route("/dashboard")
@login_required
@required_role(userRole.PARTICIPANT)
def dashboard():
	sports = session.get('sports', [])
	print(type(sports))
	return render_template("participant/dashboard.html", sports=sports)