from flask import Flask, request, jsonify
from functools import wraps
import CREDENCIALES as cr
import BDD
import Operaciones as op
import Querys as q
import os
os.system("cls")

app = Flask(__name__)


USERNAME = cr.user()
PASSWORD = cr.passwd()


def require_auth(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        auth = request.authorization
        if not auth or not (auth.username == USERNAME and auth.password == PASSWORD):
            return jsonify({"message": "Authentication required >:("}), 401
        return f(*args, **kwargs)
    return decorated



@app.route('/restaurants/statistics', methods=['GET'])
@require_auth
def get_statistics():
    latitude = request.args.get('latitude')
    longitude = request.args.get('longitude')
    radius = request.args.get('radius')

    if not all([latitude, longitude, radius]):
        return jsonify({"message": "Missing parameters"}), 400

    raiting = BDD.getDataSet(q.get_Restaurants(latitude, longitude, radius))
    data = {
        'count': op.count(raiting),
        'avg': op.avg(raiting),
        'std': op.std(raiting)
    }
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True)
