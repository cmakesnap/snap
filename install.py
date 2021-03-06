#!/usr/bin/env python

""" 
This script installs the dependences for CMake Snap including

CMake 2.8 - 
protobuf 2.6.1 - Note: Our application requires the use of -fPIC and the CPP implementation for python
Swig 2.0 - 
"""

import os
import urllib
import urllib2
import tarfile
import subprocess

def ExecuteCmd(cmd, quiet=False):
  result = None
  if quiet:    
    with open(os.devnull, "w") as fnull:    
      result = subprocess.call(cmd, shell=True, stdout = fnull, stderr = fnull)
  else:
    result = subprocess.call(cmd, shell=True)
  return result

def EnsurePath(path):
  try:
    os.makedirs(path)
  except:
    pass
  return

def InstallJava():  
  cmd = 'sudo apt-get install default-jdk'
  ExecuteCmd(cmd)
  return  

def InstallCMake():  
  cmd = 'sudo apt-get install cmake'
  ExecuteCmd(cmd)
  return  

def InstallSwig():  
  cmd = 'sudo apt-get install swig python-dev'  
  ExecuteCmd(cmd)
  return  

def InstallQt():  
  cmd = 'sudo apt-get install libqt4-dev libqt4-gui'  
  ExecuteCmd(cmd)
  return
  
def InstallProtobuffers():
  url = 'https://github.com/google/protobuf/releases/download/v2.6.1/protobuf-2.6.1.tar.gz'
    
  split = urllib2.urlparse.urlsplit(url)
  dest_filename = "/tmp/" + split.path.split("/")[-1]
  urllib.urlretrieve(url, dest_filename)
  assert(os.path.exists(dest_filename))
  tar = tarfile.open(dest_filename)
  tar.extractall('/tmp/')
  tar.close()  
  src_path = '/tmp/protobuf-2.6.1/'
  assert(os.path.exists(src_path))  
  cmd = 'cd %s && export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp && export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION_VERSION=2 && export CCFLAGS=-fPIC && export CXXFLAGS=-fPIC && ./configure && make -j10 && sudo make install && cd python && sudo PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION_VERSION=2 python setup.py install; sudo ldconfig;' % (src_path)
  ExecuteCmd(cmd)    
  cmd = 'which protoc; protoc --version'
  ExecuteCmd(cmd)
  return


if __name__ == "__main__":
  InstallJava()
  InstallQt()
  InstallCMake()
  InstallSwig()
  InstallProtobuffers()
  
