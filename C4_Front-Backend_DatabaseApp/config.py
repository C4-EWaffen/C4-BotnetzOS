import os

class Config:
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL', 'postgresql://myuser:mypassword@localhost/mydatabase')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
