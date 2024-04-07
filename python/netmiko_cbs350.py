from netmiko import ConnectHandler
import time
import socket

def ConnectMiko(p_hostip, p_hosttype):
  print("Starting netmiko script")
  labswitch = {
    'device_type': p_hosttype,
    'host':   p_hostip,
    'username': 'myusername',
    'password': 'mypassword',
    'port' : 22,
    'session_log': 'netmiko.log'
  }
  return ConnectHandler(**labswitch)

hostip = '1.2.3.4'
net_connect = ConnectMiko(hostip, 'cisco_s300')
print("Connection complete")

print("Show version")
output = net_connect.send_command('show version')
print(output)

#simple interface change
#config_commands = [ 'int Gi23', 'no switchport', 'ip address 1.2.3.4 255.255.255.0' ]
#output = net_connect.send_config_set(config_commands)
#print(output)

#print("backup running config to file")
#output3 = net_connect.send_command('show running-config')
#save_file = open("switchrun.txt","w")
#save_file.write(output3)
#save_file.close()

print("Reloading switch")
net_connect.send_command("reload", expect_string="continue")
net_connect.send_command_timing("Y", normalize=False)
net_connect.send_command_timing("Y", normalize=False)

print("Waiting for switch to come back online")
counter = 0
online = False
while (counter < 5) and (online == False):
  #sleep for a min
  time.sleep(60)
  mysocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  result = mysocket.connect_ex((hostip,22))
  if result == 0:
    print(hostip + " SSH port is open.")
    online = True
  else:
    print(hostip + " SSH still down, waiting 60 secs to try again")
  mysocket.close()
  counter += 1

net_connect.disconnect()
print("script finished.")



