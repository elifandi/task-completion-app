from flask import Flask, jsonify, request
from flask_httpauth import HTTPBasicAuth
from werkzeug.security import generate_password_hash, check_password_hash
from flask_sqlalchemy import SQLAlchemy
from flask_restful import Resource, Api

app = Flask(__name__)
api = Api(app)
#Database connection information

dbParam = 'mysql+pymysql://task:LENDev201912@localhost/taskr'
app.config['SQLALCHEMY_DATABASE_URI'] = dbParam

#Flask secret key
theKey = 'thEejrdaR5$wE3yY4wsehn4wASHR'

db = SQLAlchemy(app)

class Accounts(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20), nullable=False)
    surName = db.Column(db.String(20), nullable=False)
    email = db.Column(db.String(50), nullable=False)
    password = db.Column(db.Text)


class hello(Resource):
    def get(self):
        return 'live'
api.add_resource(hello, '/')
class UserSignUp(Resource):
    def put(self):
        #request.form("data")
        signUpData = request.get_json()

        #signUpData['name']
        name = request.form['name']
        surName = request.form['surName']
        usrEmail = request.form['email']
        unhashedPassword = request.form['password']
        #check password is same on frontend
        hashedPassword = generate_password_hash(unhashedPassword)

        #Make sure the email is not already taken
        if Accounts.query.filter_by(email=usrEmail).first() is None:
            createAccount = Accounts(email=usrEmail, name=name, surName=surName, \
            password=hashedPassword)

            #Add account to the database
            db.session.add(createAccount)
            db.session.commit()
            status = 'success'

        else: 
            status = 'failed'
        return status


api.add_resource(UserSignUp, '/signup')

  
class UserLogin(Resource):
    def post():
        #request.form("data")
        loginData = request.get_json()

        #signUpData['name']
        usrEmail = loginData['email']
        unhashedPassword = signUpData['password']
        #check password is same on frontend
        hashedPassword = generate_password_hash(unhashedPassword)

        #Make sure the email is not already taken
        if Accounts.query.filter_by(email=usrEmail,password=hashedPassword).first() is  None:
            #Login and send token
            
            

            #Add account to the database
            status = 'success'
        else: 
            status = 'failed'
        return status


api.add_resource(UserLogin, '/login')

