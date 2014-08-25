
import tornado.web
from tornado.escape import json_encode

from tornado.escape import json_encode

from models.model import *
from session import Session


class BBSApiHandler(tornado.web.RequestHandler):
  def get(self, id_):
    self.set_header("Content-Type", "text/json")
    less_than = self.get_argument("less_than",None)
    more_than = self.get_argument("more_than",None)

    responses = self.get_responses(id_, 
                                  less_than=less_than,
                                  more_than=more_than)

    self.write(json_encode(responses));
    
  def post(self, id_):
    """ Publish to BBS
    """
    errors = {}

    username = self.get_argument("username", "名無し")
    if username == "":
      username = "名無し"

    text = self.get_argument("text")
    if text == "":
      errors["text"] = True

    if not errors:
      session = Session()
      res = Response(text, username)
      res.bbs_id = id_
      session.add(res)
      session.commit()
      res = res.toDict()
      session.close()

    self.set_header("Content-Type", "text/json")
    self.write(json_encode([res]));

  
  def get_responses(self, id_=1, less_than=None, more_than=None):
    session = Session()
    bbs = session.query(BBS).filter(BBS.id == id_).one()

    responses = session.query(Response).filter(Response.bbs_id == id_)
    if less_than:
      responses = responses.filter(Response.id < less_than)
    if more_than:
      responses = responses.filter(Response.id > more_than)
    responses = responses.order_by(Response.id.desc()).limit(30).all()

    responses = [res.toDict() for res in responses]

    session.close()
    return responses


class BBSHandler(tornado.web.RequestHandler):
  def get(self, id_):
    responses = self.get_responses(id_)

    self.render("BBS/index.html",
        responses=responses)

  def post(self, id_):
    """ Publish to BBS
    """
    errors = {}

    username = self.get_argument("username", "名無し")
    if username == "":
      username = "名無し"
    mail = self.get_argument("mail")

    text = self.get_argument("text")
    if text == "":
      errors["text"] = True

    if not errors:
      session = Session()
      res = Response(text, username)
      res.bbs_id = id_
      session.add(res)
      session.commit()
      session.close()

    responses = self.get_responses(id_)

    self.render("BBS/index.html",
        responses=responses,
        errors=errors
    )
  

  def get_responses(self, id_=1):
    session = Session()
    bbs = session.query(BBS).filter(BBS.id == id_).one()

    responses = [ res.toDict() for res in bbs.responses]
    responses.reverse()
    return responses


