from flask import redirect, render_template, url_for
from flask_login import current_user, login_required

from ..decorators import required_role
from ..models import userRole
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


@p_bp.route("/my-profile")
@login_required
@required_role(userRole.PARTICIPANT)
def manage_profile():
    return render_template("participant/my_profile.html")
