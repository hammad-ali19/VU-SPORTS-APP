from . import auth_bp
from flask import request, render_template, flash, redirect, url_for, session
from .forms import RegistrationForm, LoginForm
from .. import db
from sqlalchemy import select
from ..models import User, userRole, Participant, userStatus, ParticipantSport, Sport, Coach
from flask_login import login_user, logout_user, login_required, current_user
# from werkzeug.security import generate_password_hash, check_password_hash

@auth_bp.route("/")
def redirect_login():
	return redirect(url_for("auth.login"))

@auth_bp.route("/register", methods=['POST', 'GET'])
def register():
	# return f'Current user: {current_user.is_admin()}'
	# if admin is registering user
	# from_admin = session.get("from_admin", False)
	# print(f"before form submission: {from_admin}")
	form = RegistrationForm()

	if form.validate_on_submit():

		name = form.name.data
		role = form.role.data
		selected_sports_ids = form.sports.data
		# print(selected_sports_ids)
		email = form.email.data
		# hashed_password = generate_password_hash(form.password.data)
		# print(len(hashed_password))
		if role == 'participant':
			user = User(name=name, email=email, password=form.password.data, status=userStatus.ACTIVE, role=role.upper())
		else:
			user = User(name=name, email=email, password=form.password.data, status=userStatus.PENDING, role=role.upper())
		db.session.add(user)
		db.session.commit()
		# print("user added")
		user_id = db.session.execute(select(User.id).where(User.email == email)).scalars().first()
		if role == 'participant':
			# user_id = db.session.execute(select(User.id).where(User.email==email)).scalars().first()
			user_par = Participant(user_id=user_id)
			db.session.add(user_par)
			db.session.commit()
			# print("participant added")

			part_id = db.session.execute(select(Participant.id).where(Participant.user_id==user_id)).scalars().first()

			for i in selected_sports_ids:
				ps = ParticipantSport(participant_id=part_id, sport_id=i)
				db.session.add(ps)
			db.session.commit()
			# print("participant-sport added")
			# print(f"after form submission: {from_admin}")
			if current_user.is_authenticated and current_user.is_admin():
				# session.pop("from_admin", None)
				# print(f"in auth after adding participant: {str(session.items())}")
				flash("Participant added successfully", category='success')
				return redirect(url_for("admin.dashboard"))
			flash("successfully Registered! You will be able to login after caoch approval.", category='info')
			return redirect(url_for("auth.login"))

		if role == 'coach':
			sp = db.session.get(Sport, int(selected_sports_ids[0]))
			if sp.coach:
				us = db.session.get(User, user_id)
				db.session.delete(us)
				db.session.commit()
				flash("Your selected sport already has assigned coach")
				return render_template("register.html", form=form)
			else:
				coach = Coach(expertise="Coach Expertise goes here", availability=1, user_id=user_id)
				db.session.add(coach)
				db.session.commit()
				c_id = db.session.execute(select(Coach.id).where(Coach.user_id==user_id)).scalars().first()
				sp.coach_id = c_id
				db.session.commit()
				if current_user.is_authenticated and current_user.is_admin():
					session.pop("from_admin", None)
					# print(f"in auth after adding participant: {str(session.items())}")
					flash("Coach added successfully", category='success')
					return redirect(url_for("admin.dashboard"))
				flash("Successfully registered you account! Please wait for admin approval before login ", category='info')
				return redirect(url_for("auth.login"))

	return render_template("register.html", form=form)


@auth_bp.route("/login", methods=['POST', 'GET'])
def login():
	form = LoginForm()
	if form.validate_on_submit():
		email = form.email.data
		password = form.password.data
		role = form.role.data
		stmt = select(User).where(User.email==email)
		user = db.session.execute(stmt).scalars().first()

		if not user:
			flash("Account does not exist. Please register first.", category="danger")
			return render_template("login.html", form=form)

		elif role == 'admin':
			if user.email == email and user.password == password and user.role.value == role:
				login_user(user)
				flash("You have logged in successfully", category='success')
				return redirect(url_for("admin.dashboard"))
			else:
				flash("Invalid Credentials", category="danger")
				return render_template("login.html", form=form)

		elif role == 'coach':
			if user.status.value != 'active':
				flash("Your account is pending for approval", category='info')
				return render_template("login.html", form=form)
			elif user.email == email and user.password == password and user.role.value == role:
				login_user(user)
				sport = user.coach.sport.name
				# session['coach-sport'] = sport
				flash("You have successfully logged in", category="success")
				return redirect(url_for("coach.dashboard"))
			else:
				flash("Invalid Credentials", category="danger")


		elif role == 'participant':
			if user.role.value != role:
				flash("Invalid credentials", category='danger')
				return render_template('login.html', form=form)

			par_sports = db.session.execute(select(ParticipantSport).where(ParticipantSport.participant_id == user.participant.id)).scalars().all()
			# if not par_sports:
			# 	flash("Invalid Credentials - 1", category='danger')
			# 	return render_template("login.html", form=form)
			if user.status == userStatus.BLOCKED:
				flash("Your account is blocked. please contact administrator", category='danger')
				return render_template('login.html', form=form)
			status_approved = False
			sports = []
			for par_sport in par_sports:
				if par_sport.status == 'active':
					sports.append(par_sport.sport.name)
					status_approved = True
					# break
			# session['sports'] = sports
			if status_approved:
				if user.email == email and user.password == password and user.role.value == role:
					login_user(user)
					flash("You have logged in successfully", category='success')
					return redirect(url_for("participant.dashboard"))
				else:
					flash ("Invalid Credentials 2", category='danger')
					return render_template("login.html", form=form)
			else:
				flash("Your account is pending for approval from respective coach", category="info")
				return render_template("login.html", form=form)

	return render_template("login.html", form=form)


@auth_bp.route("/logout")
@login_required
def logout():
	logout_user()
	# return render_template("login.html")
	flash("You have logged out successfully", category='success')
	# session.pop('from_admin', None)
	return redirect(url_for("auth.login"))
