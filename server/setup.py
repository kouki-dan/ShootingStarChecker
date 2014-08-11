
from setuptools import setup, find_packages

setup(name="altstars",
      packages=find_packages(),
      install_requires=["sqlalchemy","mysql-connector-python","facebook-sdk","redis"],
)

