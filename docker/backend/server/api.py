import datetime
from flask import Flask, request, Response, jsonify
from database import PostgreSQL
from flask_cors import CORS
import json
import psycopg2.extras
import psycopg2
import os

app = Flask(__name__)
cors = CORS(app)

@app.route("/")
def ok():
    return "server ok", 200


@app.route("/save/test", methods=["PUT"])
def set_repo():
    if request.method == "PUT":
        ''' exemplo de requisicao:
            {
                "accessKey": "IzJUQ0MwSm9zZTJMdWlzMg==",
                "platform": "Test",
                "protocol": "Test",
                "messageSize": 0,
                "sendTime": 1644769145108, 
                "returnTime": 1644769145108, 
                "intervalTime": 0,
                "messageDelta": 0, 
                "messagesSent": 0, 
                "messagesReceived": 0
            }
        '''
        dt = request.get_json()
        accessKey = dt["accessKey"]
        if (accessKey is None or accessKey != 'IzJUQ0MwSm9zZTJMdWlzMg=='):
            return "", 404
        base = PostgreSQL.connect()
        cursor = base.cursor()
        ''' exemplo de query
            INSERT INTO tcc.message(platform,protocol,message_size,send_time,return_time,
	            interval_time,message_delta,messages_sent,messages_received)
            VALUES('Test', 'Test', 0, '2022-02-13 12:13:0.000', '2022-02-13 12:13:00.000', 0, 0, 0, 0);
        '''
        query = 'INSERT INTO tcc.message(platform,protocol,message_size,send_time,return_time,' + \
                    'interval_time,message_delta,messages_sent,messages_received) ' + \
                    "VALUES('{0}', '{1}', {2}, '{3}', '{4}', {5}, {6}, {7}, {8});"\
                    .format(\
                        dt["platform"],
                        dt["protocol"], 
                        dt["messageSize"],
                        datetime.datetime.fromtimestamp(dt["sendTime"]/1000).strftime("%Y-%m-%d %H:%M:%S.%f")[:-3], 
                        datetime.datetime.fromtimestamp(dt["returnTime"]/1000).strftime("%Y-%m-%d %H:%M:%S.%f")[:-3], 
                        dt["intervalTime"],
                        dt["messageDelta"], 
                        dt["messagesSent"], 
                        dt["messagesReceived"])
        cursor.execute(query)
        base.commit()
        cursor.close()
        base.close()
        return "{ok: true}", 202
    else:
        return "invalid method " + request.method, 405

if __name__ == '__main__':
    # Bind to PORT if defined, otherwise default to 5000.
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)