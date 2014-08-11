
import os, sys
print(os.getcwd())
sys.path.append(os.getcwd())

from models.model import *

Base.metadata.drop_all(engine)
Base.metadata.create_all(engine)

