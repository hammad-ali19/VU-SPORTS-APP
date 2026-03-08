from flask import Flask, render_template, session

from .extensions import csrf, db, login_manager, migrate
from .models import User


def create_app():
    app = Flask(__name__, static_folder="static", static_url_path="/")
    app.config["SECRET_KEY"] = "SOMESECRETKEY"
    # app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:12345@localhost:3306/vuss'
    app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:@localhost:3306/vuss"

    db.init_app(app)
    migrate.init_app(app, db)
    csrf.init_app(app)
    login_manager.init_app(app)
    login_manager.login_view = "auth.login"
    login_manager.login_message_category = "info"

    @login_manager.user_loader
    def load_user(user_id):
        return db.session.get(User, int(user_id))

    @app.route("/")
    def home():
        return render_template("home.html")

    @app.route("/debug_session")
    def debug_session():
        # Print the entire session dictionary to console
        session.pop('coach-sport', None)
        print(session)

        # Alternatively, return the items for viewing in the browser
        return str(session.items())

    # Register Blueprints
    from .admin import a_bp
    from .auth import auth_bp
    from .coach import c_bp
    from .home import home_bp
    from .participant import p_bp

    app.register_blueprint(home_bp)
    app.register_blueprint(auth_bp)
    app.register_blueprint(p_bp)
    app.register_blueprint(c_bp)
    app.register_blueprint(a_bp)

    return app
