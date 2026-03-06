# from sqlalchemy import event, update
# from sqlalchemy.orm import Session
# from .models import Coach, ParticipantSport

# @event.listens_for(Session, "after_flush")
# def reset_participant_status(session, flush_context):
#     for obj in session.deleted:
#         if isinstance(obj, Coach):
#             # Reset status to pending when their coach is deleted
#             stmt = update(ParticipantSport).where(ParticipantSport)
#             session.query(ParticipantSport).filter_by(approved_by=obj.id).update(
#                 {"status": "pending", "approved_by": None}
#             )