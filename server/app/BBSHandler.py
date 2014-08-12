
import tornado.web
from tornado.escape import json_encode

from models.model import *
from session import Session


class BBSHandler(tornado.web.RequestHandler):
  def get(self):
    responses = self.get_responses()

    self.render("BBS/index.html",
        responses=responses)

  def post(self):
    """ Publish to BBS
    """
    pass

  def get_responses(self, id_=1):
    session = Session()
    bbs = session.query(BBS).filter(BBS.id == id_).one()

    responses = [ res.toDict() for res in bbs.responses]
    return responses

