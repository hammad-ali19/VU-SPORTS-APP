from flask import Blueprint

a_bp = Blueprint("admin", __name__, template_folder="../templates", url_prefix="/admin")


from . import routes