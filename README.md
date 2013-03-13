CMake SNAP
===================
*Author: Kyle Heath (cmakesnap [at] gmail)*

What is CMake SNAP?
-------------------------------------------------------------------------------

* A system for building software for projects with C/C++/Python/Java targets
* Makes CMakeLists.txt files very concise
* Provides a notion of reusable packages 
* Transparently manages package dependencies 

Currently supported targets: 
* CPP_BINARY - Optional mark as a test target
* CPP_LIBRARY - Optional SWIG python bindings
* PROTO_LIBRARY - Generates C++, Python, and Java libraries for a .proto file  
* PYTHON_BINARY - Optional mark as a test target
 
 
Snap aims to make building software from reusable components as easy as snapping
together Lego building blocks.  Traditional build tools require verbose 
specifications of system installed and custom library resources and their 
dependencies which requires significant overhead for each component reused and
make it more difficult for others to build the same software in a different 
computer environment.  Snap allows users to write very concise specifications 
of the desired build targets and reuse components via a simple unique package 
name scheme.  Snap makes it easier to build all of a target’s dependencies from 
source distributed with the project which eliminates many problems caused by 
variations in system installed libraries among various operating systems.  
This scheme also enables “as-static-as-possible-linking” which is required when 
compiling c/c++ binaries on one system which must be distributed and reliably 
run in another environment.  This is a basic requirement for distributed 
computing which can be difficult to achieve with conventional build tools.  Snap
is built as a set of macros for the CMake build system which is widely used in 
open source community for its speed, portability, and ease of use.
 
   
Installation
---------------

1. Download to a local directory <snap_dir>
2. Add the following to your .bashrc

```bash
# Tell CMake about the snap extensions
export cmakesnap_DIR=<snap_dir>

# Adds handy command to toggle between corresponding locations in source and
# and build directory tree with the command 'snap-toggle'
alias snap-toggle='cd `${cmakesnap_DIR}/internal/util/snap-toggle.py`'
```
