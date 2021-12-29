import json
from flask import Flask, request, Response, jsonify
from database import PostgreSQL
from flask_cors import CORS
import psycopg2.extras
import psycopg2
import os

app = Flask(__name__)
cors = CORS(app)

@app.route("/")
def ok():
    return "server ok", 200


@app.route("/save/test", methods=["POST"])
def set_repo():
    if request.method == "POST":
        dt = request.get_json()
        base = PostgreSQL.connect()
        cursor = base.cursor()
        query = "" #TODO: Query
        cursor.execute(query)
        base.commit()
        cursor.close()
        base.close()
        return "{ok: true}", 200
    else:
        return "invalid method " + request.method, 405

if __name__ == '__main__':
    # Bind to PORT if defined, otherwise default to 5000.
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)