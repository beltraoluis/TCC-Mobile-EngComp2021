#  
# stomp_test.py - test STOMP  
#  
import time  
import sys  
   
import stomp  
import random  
   
class MyListener(stomp.ConnectionListener):  
  def on_error(self, headers, message):  
    print('received an error "%s"' % message)  
  def on_message(self, message):  
    print('received a message "%s"' % message)  
   
# Define a STOMP connection and port  
conn = stomp.Connection([('192.168.0.176', 5692)])
conn.set_listener('MyListener', MyListener())
conn.connect('guest', 'guest') # define the username/password    
   
#while True:  
#time.sleep(15) # send a random message every 15 seconds  
#  conn.send(body=str(random.randint(1,11)), destination='STOMP/KEY')  

fruits = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10']

for x in fruits:
  conn.send(body=x, destination='/exchange/project.STOMPExchange/STOMP.RxKey')
#conn.disconnect()
   
time.sleep(15) # send a random message every 15 seconds  

# Setup a subscription  
conn.subscribe(destination='STOMP.Tx', id=1, ack='auto')

time.sleep(15) # send a random message every 15 seconds  

conn.disconnect()