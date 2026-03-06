from flask import Blueprint

c_bp = Blueprint("coach", __name__, template_folder="../templates", url_prefix="/coach")

from . import routes