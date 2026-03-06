from functools import wraps
from flask import abort
from flask_login import login_required, current_user


def required_role(*roles):
	def decorator(func):
		@wraps(func)
		@login_required
		def decorated_function(*args, **kwargs):
			if current_user.role not in roles:
				abort(403)
			return func(*args, **kwargs)
		return decorated_function
	return decorator
