from keyword import kwlist

from datetime import datetime
from .extensions import db
from sqlalchemy import UniqueConstraint, String, CheckConstraint, func, Enum, ForeignKey, DateTime, Integer, Text, Boolean, Date, Time
from sqlalchemy.orm import Mapped, mapped_column, relationship
import enum
from flask_login import UserMixin
from typing import Optional, List

class userStatus(enum.Enum):
    ACTIVE = 'active'
    PENDING = 'pending'
    BLOCKED = 'blocked'

class userRole(enum.Enum):
    ADMIN = 'admin'
    COACH = 'coach'
    PARTICIPANT = 'participant'


class User(db.Model, UserMixin):

    __tablename__ = 'users'

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(150), nullable=False)
    email: Mapped[str] = mapped_column(String(200), unique=True, nullable=False)
    password: Mapped[str] = mapped_column(String(255), nullable=False)
    status: Mapped[userStatus] = mapped_column(Enum(userStatus), default=userStatus.PENDING, nullable=False)
    role: Mapped[userRole] = mapped_column(Enum(userRole), nullable=False)

    participant: Mapped["Participant"] = relationship(back_populates="user", uselist=False, cascade="all, delete-orphan")
    coach: Mapped["Coach"] = relationship(back_populates="user", uselist=False, cascade="all, delete-orphan")
    admin: Mapped["Admin"] = relationship(back_populates="user", uselist=False, cascade="all, delete-orphan")
    announcements_sent: Mapped[List['Announcement']] = relationship(back_populates='sender')
    announcement_recipients: Mapped[List['AnnouncementRecipient']] = relationship(back_populates='recipient', cascade='all, delete-orphan')

    def is_admin(self):
        return self.role.value == 'admin'

    def is_coach(self):
        return self.role == 'coach'

    def is_participant(self):
        return self.role == 'participant'

    def __repr__(self):
        return f"Id: {self.id} Name: {self.name} and Email: {self.email}"

    __table_args__ = (
        CheckConstraint(
            "name REGEXP '^[A-Za-z ]+$'",
            name='chk_name_letter_only'
        ),    
    )

class Participant(db.Model, UserMixin):

    __tablename__ = 'participants'

    id: Mapped[int] = mapped_column(primary_key=True)
    university_id: Mapped[str] = mapped_column(String(14), nullable=True)
    max_sports_allowed: Mapped[int] = mapped_column(Integer, server_default="2", default=2, nullable=False)
    achievements: Mapped[str] = mapped_column(Text, nullable=True)
    past_participation: Mapped[str] = mapped_column(Text, nullable=True)

    user_id: Mapped[int] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"), unique=True, nullable=False)
    user: Mapped["User"] = relationship(
        back_populates="participant"
    )

    sports: Mapped[List['ParticipantSport']] = relationship(
        back_populates='participant',
        cascade='all, delete-orphan'
    )
    teams: Mapped[List['TeamParticipant']] = relationship(back_populates='participant',cascade='all, delete-orphan')
    events: Mapped[List['EventRegistration']] = relationship(back_populates='participant', cascade='all, delete-orphan')

    def __repr__(self):
        return f"<Id: {self.id}, Name: {self.user.name}>"


class Coach(db.Model, UserMixin):

    __tablename__ = 'coaches'

    id: Mapped[int] = mapped_column(primary_key=True)
    expertise: Mapped[str] = mapped_column(Text, nullable=False)
    availability: Mapped[bool] = mapped_column(Boolean, nullable=False)

    user_id: Mapped[int] = mapped_column(ForeignKey("users.id", ondelete="CASCADE"), unique=True, nullable=False)

    user: Mapped["User"] = relationship(back_populates="coach")
    sport: Mapped['Sport'] = relationship(back_populates='coach', uselist=False)
    teams: Mapped[List['Team']] = relationship(back_populates='coach')

    def is_available(self):
        return self.availability

class Admin(db.Model, UserMixin):

    __tablename__ = 'admins'

    id: Mapped[int] = mapped_column(primary_key=True)
    level: Mapped[str] = mapped_column(String(10), server_default="NORMAL", default="NORMAL")

    user_id: Mapped[int] = mapped_column(ForeignKey("users.id", ondelete='CASCADE'), unique=True, nullable=False)

    user: Mapped['User'] = relationship(back_populates='admin')

class Sport(db.Model):

    __tablename__ = 'sports'

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(20), unique=True, nullable=False)
    description: Mapped[str] = mapped_column(Text, nullable=True)
    max_participants: Mapped[Optional[int]] = mapped_column(Integer, nullable=True)

    coach_id: Mapped[int] = mapped_column(ForeignKey("coaches.id", ondelete="SET NULL"), unique=True, nullable=True)
    coach: Mapped['Coach'] = relationship(back_populates='sport', uselist=False)

    participants: Mapped[List["ParticipantSport"]] = relationship(
        back_populates='sport',
        cascade='all, delete-orphan'
    )

    events: Mapped[List['Event']] = relationship(back_populates='sport')
    teams: Mapped[List['Team']] = relationship(back_populates='sport')

    def __repr__(self):
        return f"Id: {self.id} Name: {self.name} Max-Participants {self.max_participants}"


class ParticipantSport(db.Model):

    __tablename__ = 'participants_sports'

    id: Mapped[int] = mapped_column(primary_key=True)
    status: Mapped[str] = mapped_column(
        String(20),
        default='pending',
        server_default='pending'
    )
    approved_by: Mapped[Optional[int]] = mapped_column(
        ForeignKey('coaches.id', ondelete='SET NULL'),
        nullable=True
    )
    participant_id: Mapped[int] = mapped_column(
        ForeignKey("participants.id", ondelete='CASCADE'),
        nullable=False
    )
    sport_id: Mapped[int] = mapped_column(
        ForeignKey("sports.id", ondelete='CASCADE'),
        nullable=False
    )

    participant: Mapped['Participant'] = relationship(back_populates='sports')
    sport: Mapped['Sport'] = relationship(back_populates='participants')

    __table_args__ = (
        db.UniqueConstraint('participant_id', 'sport_id', name='uq_participant_sport'),
    )
    def __repr__(self):
        return f"<ParticipantName: {self.participant.user.name}, SportName: {self.sport.name}>"

class Venue(db.Model):
    __tablename__ = 'venues'

    id: Mapped[int] = mapped_column(primary_key=True)
    location: Mapped[str] = mapped_column(Text, nullable=False)
    availability: Mapped[bool] = mapped_column(Boolean, nullable=False)

    events: Mapped[List['Event']] = relationship(back_populates='venue')

class Event(db.Model):
    __tablename__ = 'events'

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(128), nullable=False)
    event_type: Mapped[Optional[str]] = mapped_column(Text)
    date_time: Mapped[datetime] = mapped_column(DateTime, nullable=False, server_default=func.now(), unique=True)

    sport_id: Mapped[int] = mapped_column(ForeignKey("sports.id", ondelete='SET NULL'), nullable=True)
    # coach_id: Mapped[int] = mapped_column(ForeignKey("coaches.id", ondelete='SET NULL'))
    venue_id: Mapped[int] = mapped_column(ForeignKey("venues.id", ondelete='SET NULL'), nullable=True)

    sport: Mapped['Sport'] = relationship(back_populates='events')
    venue: Mapped['Venue'] = relationship(back_populates='events')
    event_participants: Mapped[List['EventRegistration']] = relationship(back_populates='event', cascade='all, delete-orphan')

    def __repr__(self):
        return f"<{self.name}, {self.venue.location}, {self.date_time}>"

class Team(db.Model):
    __tablename__ = 'teams'

    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(100), nullable=False)
    max_participants: Mapped[int] = mapped_column(Integer, nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime, server_default=func.now(), nullable=False)

    sport_id: Mapped[int] = mapped_column(ForeignKey("sports.id", ondelete='CASCADE'), nullable=False)
    coach_id: Mapped[int] = mapped_column(ForeignKey("coaches.id", ondelete='CASCADE'), nullable=False)

    sport: Mapped['Sport'] = relationship(back_populates='teams')
    coach: Mapped['Coach'] = relationship(back_populates='teams')
    members: Mapped[List['TeamParticipant']] = relationship(back_populates='team', cascade='all, delete-orphan')

    def __repr__(self):
        return f"<ID: {self.id}, Team Name: {self.name}, Members: {len(self.members)}>"

class TeamParticipant(db.Model):
    __tablename__ = 'team_participants'

    id: Mapped[int] = mapped_column(primary_key=True)
    joined_at: Mapped[datetime] = mapped_column(DateTime, server_default=func.now(), nullable=False)

    team_id: Mapped[int] = mapped_column(ForeignKey("teams.id", ondelete='CASCADE'), nullable=False)
    participant_id: Mapped[int] = mapped_column(ForeignKey("participants.id", ondelete='CASCADE'), nullable=False)

    team: Mapped['Team'] = relationship(back_populates='members')
    participant: Mapped['Participant'] = relationship(back_populates='teams')

    __table_args__ = (
        db.UniqueConstraint('team_id', 'participant_id', name='uq_team_participant'),
    )

class Announcement(db.Model):
    __tablename__ = 'announcements'

    id: Mapped[int] = mapped_column(primary_key=True)
    title: Mapped[str] = mapped_column(String(150), nullable=False)
    body: Mapped[str] = mapped_column(Text, nullable=False)
    created_at: Mapped[datetime] = mapped_column(DateTime, server_default=func.now(), nullable=False)
    sender_id: Mapped[int] = mapped_column(ForeignKey('users.id', ondelete='SET NULL'), nullable=True)

    sender: Mapped['User'] = relationship(back_populates='announcements_sent')
    recipients: Mapped[List['AnnouncementRecipient']] = relationship(back_populates='announcement', cascade='all, delete-orphan')

    def __repr__(self):
        return f"<Announcement {self.id} by {self.sender.name if self.sender else 'Unknown'}>"

class AnnouncementRecipient(db.Model):
    __tablename__ = 'announcement_recipients'

    id: Mapped[int] = mapped_column(primary_key=True)
    announcement_id: Mapped[int] = mapped_column(ForeignKey('announcements.id', ondelete='CASCADE'), nullable=False)
    recipient_id: Mapped[int] = mapped_column(ForeignKey('users.id', ondelete='CASCADE'), nullable=False)

    announcement: Mapped['Announcement'] = relationship(back_populates='recipients')
    recipient: Mapped['User'] = relationship(back_populates='announcement_recipients')

    __table_args__ = (
        db.UniqueConstraint('announcement_id', 'recipient_id', name='uq_announcement_recipient'),
    )

class EventRegistration(db.Model):
    __tablename__ = 'event_registrations'

    id: Mapped[int] = mapped_column(primary_key=True)

    participant_id: Mapped[int] = mapped_column(ForeignKey("participants.id", ondelete='CASCADE'), nullable=False)
    event_id: Mapped[int] = mapped_column(ForeignKey("events.id", ondelete='CASCADE'), nullable=False)

    event: Mapped['Event'] = relationship(back_populates='event_participants')
    participant: Mapped['Participant'] = relationship(back_populates='events')

    __table_args__ = (
        db.UniqueConstraint('event_id', 'participant_id', name='uq_event_registration'),
    )