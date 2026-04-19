from flask import Blueprint

cs_bp = Blueprint("chatsection", __name__, template_folder="../templates", url_prefix="/getintouch")

from . import routes