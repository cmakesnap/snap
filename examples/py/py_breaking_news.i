%module py_breaking_news

%include "examples/myproto.swig"

%{
//#include "examples/myproto.pb.h"
#include "examples/py/breaking_news.h"
%}

%include "examples/py/breaking_news.h"
