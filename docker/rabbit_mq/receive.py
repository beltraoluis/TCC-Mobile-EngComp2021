import os
import pika  # python -m pip install pika --upgrade
import urllib.parse as urlparse
import time

credentials = pika.PlainCredentials('Luis', 'luis')
connection = pika.BlockingConnection(
    pika.ConnectionParameters('localhost', '5672', '/', credentials)
)

channel = connection.channel()

def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)

channel.basic_consume(queue='AMQP.Tx', on_message_callback=callback, auto_ack=True)

channel.start_consuming()

time.sleep(30) # send a random message every 15 seconds  