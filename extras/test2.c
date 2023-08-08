// operator delete[] example
#include <iostream>     // std::cout

struct MyClass {
  MyClass() {std::cout <<"MyClass constructed\n";}
  ~MyClass() {std::cout <<"MyClass destroyed\n";}
};

int main () {
  MyClass * pt;

  pt = new MyClass[3];
  delete[] pt;

  return 0;
}