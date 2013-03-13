#include "examples/cpp/base64/encode.h"
#include "examples/cpp/base64/decode.h"
#include <sstream>

using namespace std;

int main(int argc, char **argv) {
  stringstream input;
  input << "The quick brown fox...";

  stringstream encoded;
  base64::encoder encoder;
  encoder.encode(input, encoded);

  stringstream decoded;
  base64::decoder decoder;
  decoder.decode(encoded, decoded);

  cout << "input: " << input.str() << endl;
  cout << "encoded: " << encoded.str() << endl;
  cout << "decoded: " << decoded.str() << endl;

  bool test_failed = false;
  if (encoded.str() != "VGhlIHF1aWNrIGJyb3duIGZveC4uLg==\n"){
    test_failed = true;
  }

  if ( input.str() != decoded.str() ){
    test_failed = true;
  }

  return test_failed;
}
