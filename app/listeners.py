from sqlalchemy import event, update
from sqlalchemy.orm import Session
from .models import Coach, ParticipantSport, Message
from . import db
from flask_socketio import emit, join_room
from flask_login import current_user
from .extensions import socketio



# @event.listens_for(Session, "after_flush")
# def reset_participant_status(session, flush_context):
#     for obj in session.deleted:
#         print("Deleted being object", obj)
#         if isinstance(obj, Coach):
#         #  Reset status to pending when their coach is deleted
#             stmt = update(ParticipantSport).where(ParticipantSport.approved_by == obj.id).values(status='pending', approved_by=None)
#             db.session.execute(stmt)








# from sqlalchemy import event, update
# from sqlalchemy.orm import Session

@event.listens_for(Session, "before_flush")
def reset_participant_status(session, flush_context, instances):
    for obj in session.deleted:
        if isinstance(obj, Coach):
            stmt = (
                update(ParticipantSport)
                .where(ParticipantSport.approved_by == obj.id)
                .values(status="pending", approved_by=None)
            )
            db.session.execute(stmt)


def get_room(user1, user2):
    return f"chat_{min(user1, user2)}_{max(user1, user2)}"


@socketio.on('join_chat')
def join_chat(data):
    other_user_id = data['other_user_id']
    room = get_room(current_user.id, other_user_id)
    join_room(room)


@socketio.on('send_message')
def send_message(data):
    receiver_id = data['receiver_id']
    content = data['message']

    if not content:
        return

    room = get_room(current_user.id, receiver_id)

    msg = Message(
        sender_id = current_user.id,
        receiver_id = receiver_id,
        content = content
    )
    db.session.add(msg)
    db.session.commit()

    emit('receive_message', {
        'sender_id': current_user.id,
        'sender_name': current_user.name,
        'message': content,
        'timestamp': str(msg.timestamp)
    }, room=room)