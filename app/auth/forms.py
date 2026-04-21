from flask_wtf import FlaskForm
from wtforms import widgets, StringField, SubmitField, PasswordField, SelectMultipleField, EmailField, SelectField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError, Regexp
from app.models import Sport, User
from sqlalchemy import select
from app import db


class MultiCheckboxField(SelectMultipleField):
    # A multiple-select field that displays as a list of checkboxes.
    widget = widgets.ListWidget(prefix_label=False)
    option_widget = widgets.CheckboxInput()


class RegistrationForm(FlaskForm):
    name = StringField("Name: ", validators=[DataRequired(message='Name is required.'), Length(min=3), Regexp(r'^[A-Za-z ]+$', message='Name must contain only letters')], render_kw={'placeholder': "Enter your name"})
    email = EmailField("Email: ", validators=[DataRequired(message='Email is required.'), Email()], render_kw={'placeholder': "Enter your email"})
    password = PasswordField("Create Password: ", validators=[Length(min=6, message='Password must be at least 6 characters long.')], render_kw={'placeholder': "Enter your password"})
    confirm_password = PasswordField("Confirm Password: ", validators=[Length(min=6, message='Password must be at least 6 characters long.'), EqualTo('password', message='Passwords do not match.')], render_kw={'placeholder': "Confirm password"})
    choices = [("", "Select a role"),("participant", "Participant"), ("coach", "Coach")]
    role = SelectField("Role: ", choices=choices, default="", validators=[DataRequired(message='Select your role.')])

    sports = MultiCheckboxField(
    	"Select Sport: ",
    	coerce=int,
    	)
    # sport_options = [("", "Select a sport"), ("cricket", "Cricket"), ("badminton", "Badminton"), ("football", "Football")]
    # sport = SelectField("Sport", choices=sport_options, default="", validators=[DataRequired()])

    register = SubmitField("Register")

    def __init__(self, *args, **kwargs):
        super(RegistrationForm, self).__init__(*args, **kwargs)
        sports = db.session.execute(select(Sport)).scalars().all()
        self.sports.choices = [
            (sport.id, sport.name) for sport in sports
        ]

    def validate_email(self, field):
        user = db.session.execute(select(User).where(User.email==field.data)).scalars().first()
        if user:
            field.errors.append(f"{user.role.value} with this email already exist")


    def validate_sports(self, field):
        selected_sports = field.data or []
        role = self.role.data

        if len(selected_sports)==0:
            raise ValidationError("Please select at least one sport")

        if role == "coach" and len(selected_sports) != 1:
            raise ValidationError("Coach must select exactly 1 sport.")

        if role == "participant" and len(selected_sports) > 2:
            raise ValidationError("Participant can select maximum 2 sports.")
        
        return True


class LoginForm(FlaskForm):
	email = StringField("Email: ", validators=[DataRequired(), Email()], render_kw={'placeholder': "Enter email"})
	password = PasswordField("Password: ", validators=[DataRequired()], render_kw={'placeholder': "Enter password"})
	options = [("", "Select a role"),("participant", "Participant"), ("coach", "Coach"), ("admin", "Admin")]
	role = SelectField("Role: ", choices=options, default="", validators=[DataRequired()])
	submit = SubmitField("Login")