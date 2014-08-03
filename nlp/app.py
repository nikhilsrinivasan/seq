
from flask import Flask, jsonify, request
from nlp import engine

app = Flask(__name__)
app.config['DEBUG'] = True

@app.route('/', methods=['GET'])
def index():
    query = request.args.get("q", "")
    return jsonify(contexts=engine.get_contexts(query))

if __name__ == "__main__":
    app.run(debug=True)
