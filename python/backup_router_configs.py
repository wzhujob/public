#some switch require: "ip ssh password-auth"
from netmiko import ConnectHandler
import time
import socket

def connect_netmiko(p_hostip, p_hosttype):
  print("Starting netmiko script")
  labswitch = {
    'device_type': p_hosttype,
    'host':   p_hostip,
    'username': 'username',
    'password': 'password',
    'port' : 22,
    'session_log': 'netmiko.log',
  }
  return ConnectHandler(**labswitch)

def restart_switch(p_connection_handle):
  print("Reloading switch")
  p_connection_handle.send_command("reload", expect_string="continue")
  p_connection_handle.send_command_timing("Y", normalize=False)
  p_connection_handle.send_command_timing("Y", normalize=False)
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

def save_config_to_file(p_hostname, p_filename, p_string):
  if p_string:
    data_dir = "C:\\data\\net\\"
    data_file = data_dir + p_hostname + "_" + p_filename + ".txt"
    print("Saving data to: " + data_file)
    with open (data_file, "w") as myfile:
      print(p_string, file=myfile) 
  
print("===Program Started===")
hostip = "10.1.2.3"
hostname = "labswitch"
connection_handle = connect_netmiko(hostip, 'cisco_s300')
print("Connection complete")

print("Retrieving Running Config")
response1 = connection_handle.send_command('sh run')
save_config_to_file("labswitch", "running_config", response1)

print("Retrieving Interface Status")
response2 = connection_handle.send_command('sh ip int')
save_config_to_file("labswitch", "interface", response2)

print("Retrieving Logs")
response3 = connection_handle.send_command('sh logging')
save_config_to_file("labswitch", "logs", response3)

#simple interface change
#config_commands = [ 'int Gi23', 'no switchport', 'ip address 1.2.3.4 255.255.255.0' ]
#output = net_connect.send_config_set(config_commands)
#print(output)

#print("backup running config to file")
#output3 = net_connect.send_command('show running-config')
#save_file = open("switchrun.txt","w")
#save_file.write(output3)
#save_file.close()

connection_handle.disconnect()
print("===script finished.===")



