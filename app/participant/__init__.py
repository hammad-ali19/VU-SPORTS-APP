from flask import Blueprint

p_bp = Blueprint("participant", __name__, template_folder="../templates", url_prefix="/participant")

from . import routes