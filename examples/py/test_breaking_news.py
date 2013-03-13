#!/usr/bin/python
import sys
import os

def main():
  project_root = os.path.abspath('%s/../../' % os.path.dirname(os.path.abspath(__file__)))
  print project_root
  sys.path.append(project_root)
  
  from examples import myproto_pb2
  from examples.py import py_breaking_news as bn
  
  person1 = myproto_pb2.Person()
  person1.id = 10
  person1.first_name = 'john'
  person1.last_name = 'doe'
  
  assert(person1.IsInitialized())
  print person1
    
  person2 = myproto_pb2.Person()
  person2.id = 11
  person2.first_name = 'jane'
  person2.last_name = 'doe'
  
  dog = myproto_pb2.Dog()
  dog.id = 1
  dog.name = 'fido'
    
  bn.Hello(person1, person2)
  bn.Bite(dog, person1)
  
  jd = bn.CreateJohnDoe()
  print jd
  sys.exit(0)
  return
        
if __name__ == "__main__": 
  main()
  sys.exit(0)
    

