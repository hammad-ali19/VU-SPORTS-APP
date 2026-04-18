from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.orm import declarative_base
from flask_migrate import Migrate
from flask_wtf import CSRFProtect
from flask_login import LoginManager
from flask_mailman import Mail


Base = declarative_base()

db = SQLAlchemy(model_class=Base)
migrate = Migrate()
csrf = CSRFProtect()
login_manager = LoginManager()
mail = Mail()