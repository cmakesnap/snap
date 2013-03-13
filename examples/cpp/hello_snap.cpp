#include "examples/cpp/base64/base64.h"
#include "examples/cpp/handy_header_lib.hpp"
#include <sstream>
#include <vector>

using namespace std;

void PrintThings(const vector<string>& things){
  for (int i=0; i < things.size(); ++i){
    cout << i << " - " << things[i] << endl;
  }
  cout << endl;
}

int main(int argc, char **argv) {
  vector<string> things_to_say;
  things_to_say.push_back("The quick brown fox...");
  things_to_say.push_back("An apple a day...");
  things_to_say.push_back("To be or not to be...");

  cout << "Things..." << endl;
  PrintThings(things_to_say);

  // Use header only library
  Sort(&things_to_say);
  cout << "Sorted things..." << endl;
  PrintThings(things_to_say);

  // Use the static base64 library
  vector<string> base64_encoded_things;
  for (int i=0; i < things_to_say.size(); ++i){
    stringstream input;
    input << things_to_say[i];
    stringstream encoded;
    base64::encoder encoder;
    encoder.encode(input, encoded);
    base64_encoded_things.push_back(encoded.str());
  }
  cout << "Encoded things..." << endl;
  PrintThings(base64_encoded_things);

  vector<string> decoded_things;
  for (int i=0; i < base64_encoded_things.size(); ++i){
    stringstream encoded;
    encoded << base64_encoded_things[i];
    stringstream decoded;
    base64::decoder decoder;
    decoder.decode(encoded, decoded);
    decoded_things.push_back(decoded.str());
  }
  cout << "Decoded things..." << endl;
  PrintThings(decoded_things);

  return 0;
}
