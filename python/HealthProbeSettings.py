import datetime    # For timestamp
import time        # For timestamp
import os          # For fileexists
import json        # For json

#error log handling
def logmsg(msg, priority=7):
  if priority <= 7:
    print(msg)

#create the settings file
def CreateSettings(settingsFileName):
  logmsg("Creating new settings file at: " + settingsFileName)
  #default dictionary values
  defaultDictionary = {
    "server": [{"name":"DC","port 445":True,"ping":True,"lastEmailTime":0},
             {"name":"Gateway","port 443":True,"ping":True,"lastEmailtime":0}
            ],
    "lastupdate":0
  }

  #try opening the file for writing, and then return default settings
  try:
    with open(settingsFileName, "w") as settingsFile:
      json.dump(defaultDictionary, settingsFile)
  except Exception as err:
    logmsg(f"error {err=},{type(err)=}",3)
  return defaultDictionary


def ReadSettings(settingsFileName):
  readSuccessful = False
  if os.path.isfile(settingsFileName):
    #file exists
    with open(settingsFileName, "rt") as settingsFile:
      try:
        settingsDic = json.load(settingsFile)
        readSuccessful = True
        logmsg("Read settings successfully from file: " + settingsFileName)
        return settingsDic
      except:
        logmsg("can't parse email time")
        readSuccessful = False
  else:
    readSuccessful = False

  if (readSuccessful == False):
    return CreateSettings(myFile)

def WriteSettings(settingsFileName, settingsDic):
  #try opening the file for writing
  try:
    with open(settingsFileName, "w") as settingsFile:
      json.dump(settingsDic, settingsFile)
    return 0
  except Exception as err:
    logmsg(f"error {err=},{type(err)=}",3)
    return 1

logmsg("HealthProbe Settings Started")
myFile = "./healthprobe.dat"
#mydict = {}
#mydict = ReadSettings(myFile)
#logmsg(mydict)
