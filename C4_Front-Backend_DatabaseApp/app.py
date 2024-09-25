from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config.from_object('config.Config')
db = SQLAlchemy(app)

class Connection(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    type = db.Column(db.String(50))
    details = db.Column(db.String(200))

@app.route('/connections', methods=['POST'])
def create_connection():
    data = request.get_json()
    new_connection = Connection(type=data['type'], details=data['details'])
    db.session.add(new_connection)
    db.session.commit()
    return jsonify({'message': 'Connection created'}), 201

@app.route('/connections', methods=['GET'])
def get_connections():
    connections = Connection.query.all()
    return jsonify([{'id': conn.id, 'type': conn.type, 'details': conn.details} for conn in connections])

if __name__ == '__main__':
    db.create_all()
    app.run(debug=True)
