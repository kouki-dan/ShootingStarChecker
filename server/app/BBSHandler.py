
import tornado.web
from tornado.escape import json_encode

from models.model import *
from session import Session


class BBSHandler(tornado.web.RequestHandler):
  def get(self):
    responses = self.get_responses()

    self.render("BBS/index.html",
        responses=responses)

  def get_responses(self):
    return [
        {"name":"Your name", "text":"your text"},
        {"name":"Your name", "text":"your text"},
        {"name":"Your name", "text":"your text"},
        {"name":"Your name", "text":"your text"},
        {"name":"Your name", "text":"your text"},
    ]



