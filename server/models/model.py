
from datetime import datetime

import sqlalchemy
import sqlalchemy.ext.declarative

from sqlalchemy import Column, Sequence, Integer, String, Boolean, DateTime, Text, Enum, ForeignKey, BigInteger
from sqlalchemy.orm import relationship, backref, relation


class BaseBase(object):
  def toDict(self):
    model = {}
    for column in self.__table__.columns:
        model[column.name] = str(getattr(self, column.name))
    return model

Base = sqlalchemy.ext.declarative.declarative_base(cls=BaseBase)

class ShootingStar(Base):
  __tablename__ = "shooting_star"
  id = Column(Integer, Sequence('content_id_seq'), primary_key=True)
  name = Column(Text())
  others = Column(Text())

class BBS(Base):
  __tablename__ = "bbs"
  id = Column(Integer, Sequence('content_id_seq'), primary_key=True)
  name = Column(Text())

class Response(Base):
  __tablename__ = "response"
  id = Column(Integer, Sequence('content_id_seq'), primary_key=True)
  username = Column(Text())
  created = Column(DateTime)
  text = Column(Text())
#relationship
  relationship("BBS", backref="responses")


# FOR DEBUG #
url = 'sqlite://'
engine = sqlalchemy.create_engine(url, echo=True)
Base.metadata.create_all(engine)

