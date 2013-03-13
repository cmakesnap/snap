#pragma once

#include "examples/myproto.pb.h"

void Hello(const myproto::Person& person1, const myproto::Person& person2);

void Bite(const myproto::Dog& dog, const myproto::Person& person);

void CreateJohnDoe(myproto::Person* new_john);

