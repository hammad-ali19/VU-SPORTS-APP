from flask import Blueprint

home_bp = Blueprint("home", __name__, template_folder="../templates", url_prefix='/app')

from . import routes