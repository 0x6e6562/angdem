# Overview

Angdem is a demo app for showing how an AngularJS client can be hooked up to a Sinatra app. Note that this currently uses Angular 0.10.6.

# Preparing, Running

....still need to write this

# OSX 

The driver I'm currently using seems to fall back on a system library on OSX. To get it on the load path, you may need to do this:

  $ export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
  
# Licensing

This is just a demo, so realistically speaking, putting a license on this is a bit irrelevant. However, for the avoidance of doubt, this code is published under the Apache 2 license.