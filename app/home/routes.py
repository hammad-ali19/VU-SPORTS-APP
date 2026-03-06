from flask import render_template
from . import home_bp

# home_bp = Blueprint("home", __name__)

@home_bp.route("/")
def home():
	return render_template('home.html')

@home_bp.route("/about")
def about_us():
	return "<h5>This is about us page</h5>"