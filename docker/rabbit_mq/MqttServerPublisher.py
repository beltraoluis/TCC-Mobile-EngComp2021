import os
from urllib.parse import urlparse
import paho.mqtt.client as mosquitto
import time

# Define event callbacks
def on_connect(self, mosq, obj, rc):
    print("rc: " + str(rc))

def on_message(mosq, obj, msg):
    print(msg.topic + " " + str(msg.qos) + " " + str(msg.payload))

def on_publish(mosq, obj, mid):
    print("mid: " + str(mid))

def on_subscribe( mosq, obj, mid, granted_qos):
    print("Subscribed: " + str(mid) + " " + str(granted_qos))

def on_log(mosq, obj, level, string):
    print(string)

mqttc = mosquitto.Client(client_id="mqttClient", clean_session=False)
# Assign event callbacks
mqttc.on_message = on_message
mqttc.on_connect = on_connect
mqttc.on_publish = on_publish
mqttc.on_subscribe = on_subscribe

# Uncomment to enable debug messages
#mqttc.on_log = on_log

# Parse CLOUDAMQP_MQTT_URL (or fallback to localhost)
url_str = os.environ.get('CLOUDAMQP_MQTT_URL', 'mqtt://localhost:5682')
url = urlparse(url_str)

# Connect
mqttc.username_pw_set('mqttUser', 'mqttUser')
#mqttc.will_set("MQTT/RxKey", "TESTE", 1, True)
mqttc.connect('localhost', 5682, 60)
mqttc.loop_start()

# Publish a message
fruits = ['uva', 'maca', 'banana', 'pera', 'manga', 'limao', 'melao', 'maracuja', 'cereja', 'laranja']

# Start subscribe, with QoS level 0
#mqttc.subscribe("MQTT/TxKey", 1)

time.sleep(5) # send a random message every 15 seconds

for x in fruits:
    mqttc.publish("MQTT/RxKey", x, qos=1)

time.sleep(20) # send a random message every 15 seconds

mqttc.disconnect()
#mqttc.loop_stop()
mqttc.loop_forever()

# Continue the network loop, exit when an error occurs
#rc = 0
#while rc == 0:
#    rc = mqttc.loop()
#print("rc: " + str(rc))