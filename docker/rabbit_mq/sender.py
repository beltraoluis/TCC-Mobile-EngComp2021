import os
import pika  # python -m pip install pika --upgrade
import urllib.parse as urlparse

credentials = pika.PlainCredentials('Luis', 'luis')
connection = pika.BlockingConnection(
    pika.ConnectionParameters('localhost', '5672', '/', credentials)
)

channel = connection.channel()

fruits = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']

for x in fruits:
    channel.basic_publish(exchange='project.AMQPExchange', routing_key='AMQP.1', body=x)

print("publish AMQP ended")

connection.close()