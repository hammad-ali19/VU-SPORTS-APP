from sqlalchemy import event, update
from sqlalchemy.orm import Session
from .models import Coach, ParticipantSport
from . import db

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