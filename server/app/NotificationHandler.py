
from app.BaseHandler import BaseHandler
from models.model import User, DeviceToken
from tornado.escape import json_encode
import tornado
import tornado.web
from apns import APNs, Frame, Payload

from session import Session

class NotificationHandler(BaseHandler):
  def get(self):
    self.render("notification/notification.html",
          users=self.get_usernames(),
    )
    
  def post(self):
    name = self.get_argument("name")
    text = self.get_argument("text")
    
    session = Session()
    tokens = session.query(DeviceToken, User).\
        filter(DeviceToken.user_id == User.id).\
        filter(User.name == name).all()
    tokens = [token.DeviceToken.device_token for token in tokens]
    session.close()

    apns = APNs(use_sandbox=True, cert_file='app/server_certificates_sandbox.pem')
    payload = Payload(alert=text, sound="default", badge=1)
    for token in tokens:
      apns.gateway_server.send_notification(token, payload)

    self.render("notification/notification.html",
          status="Success",
          users=self.get_usernames(),
    )
  def get_usernames(self):
    users = set()
    session = Session()
    tokens = session.query(DeviceToken).all()
    for token in tokens:
      users.add(token.user.name)
    return users

    




