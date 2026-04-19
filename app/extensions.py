from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import declarative_base
from flask_migrate import Migrate
from flask_wtf import CSRFProtect
from flask_login import LoginManager
from flask_mailman import Mail
from flask_socketio import SocketIO


Base = declarative_base()

db = SQLAlchemy(model_class=Base)
migrate = Migrate()
csrf = CSRFProtect()
login_manager = LoginManager()
mail = Mail()
socketio = SocketIO()