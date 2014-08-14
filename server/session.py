
#For test
from models.model import *
from sqlalchemy.orm import sessionmaker
Session = sessionmaker(bind=engine)


# Insert test data 
session = Session()
bbs = BBS(name="first BBS")

for i in range(10):
  res = Response("textext{}".format(i), "namee")
  bbs.responses.append(res)

session.add(bbs)
session.commit()
      
