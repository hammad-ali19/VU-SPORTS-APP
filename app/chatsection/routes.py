from flask import render_template
from app.models import Message, User, Coach, Participant
from . import cs_bp
from app import db
from flask_login import login_required, current_user
from sqlalchemy import select

@cs_bp.route('/chat/<int:user_id>', methods=['POST', 'GET'])
@login_required
def chat(user_id):
    messages = Message.query.filter(
        ((Message.sender_id == current_user.id) & (Message.receiver_id == user_id)) |
        ((Message.sender_id == user_id) & (Message.receiver_id == current_user.id))
    ).order_by(Message.timestamp).all()
    print(user_id, type(user_id))
    other_user = db.session.get(User, user_id)
    
    # if not other_user:
    #     other_user = db.session.get(Participant, user_id)

    # other_user = db.session.execute(select(User).where(User.id == other_user.user_id)).scalar()
    # print(other_user.id, other_user.name)
    return render_template("chat.html", messages=messages, other_user=other_user)

@cs_bp.route('/chats')
@login_required
def chat_list():
    users = User.query.all()
    return render_template("chat_list.html", users=users)