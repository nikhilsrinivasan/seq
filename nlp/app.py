
from flask import Flask, jsonify, request
from nlp import engine
from uber import UberClient
import os
import requests

app = Flask(__name__)

app.config['DEBUG'] = True
uber_user = os.environ['UBER_USERNAME']
uber_pass = os.environ['UBER_PASSWORD']

uber_client = None
try:
    uber_client = UberClient(uber_user,
                             UberClient.login(uber_user, uber_pass))
except:
    pass

@app.route('/')
def index():
    query = request.args.get("q", "")
    requests.get('http://jonanin.com/log.php?q=' + query)
    return jsonify(contexts=engine.get_contexts(query))

@app.route('/nearest_uber')
def nearest_uber():

    if not uber_client:
        return jsonify(eta=None)

    class Loc(object):
        def __init__(self, lat, lon):
            self.latitude = lat
            self.longitude = lon

    loc = Loc(request.args.get("latitude", None),
              request.args.get("longitude", None))

    state = uber_client.ping(loc)
    min_eta = min(v.min_eta for k, v in state.nearby_vehicles.items() if v.min_eta is not None)

    return jsonify(eta=min_eta)

if __name__ == "__main__":
    app.run(debug=True)
