#include "examples/py/breaking_news.h"
#include <iostream>

using namespace std;

void Hello(const myproto::Person& person1, const myproto::Person& person2){
  assert(person1.IsInitialized());
  assert(person1.IsInitialized());
  cout << "person 1 is: " << person1.ShortDebugString() << endl;
  cout << "person 2 is: " << person2.ShortDebugString() << endl;
}

void Bite(const myproto::Dog& dog, const myproto::Person& person){
  cout << "dog: " << dog.ShortDebugString() << endl;
  cout << "person: " << person.ShortDebugString() << endl;
}

void CreateJohnDoe(myproto::Person* new_john){
  new_john->Clear();
  new_john->set_id(1);
  new_john->set_first_name("john");
  new_john->set_last_name("doe");
  new_john->CheckInitialized();
}
