
import tornado.web
from tornado.escape import json_encode

from models.model import *
from session import Session


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


