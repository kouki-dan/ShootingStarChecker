
import uuid

import tornado.web
from tornado.escape import json_encode

from models.model import *
from session import Session

class AuthLoginHandler(tornado.web.RequestHandler):
  def get(self):
    self.render("auth/login.html")


class AuthLogoutHandler(tornado.web.RequestHandler):
  def get(self):
    self.render("auth/logout.html")


