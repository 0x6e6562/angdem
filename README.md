# Overview

Angdem is a demo app for showing how an AngularJS client can be hooked up to a Sinatra app. Note that this currently uses Angular 0.10.6 and backs off to a MySQL DB.

# MySQL

Don't forget to add a user called angdem_user with access to the angdem DB (need to environmentalize this).

  create database angdem;
  create user 'angdem_user'@'localhost' indentified by 'angdem_user';
  grant all privileges on angdem.* to 'angdem_user'@'localhost';

Then you will need to run the schema migration so that the DB gets the DDL it needs (using sequel):

  $ sequel -m db/migrations mysql2://angdem_user:angdem_user@localhost/angdem 

# Running The App

  $ thin start

# Using MySQL on OSX

If you get a load error like this:

   Reason: image not found - ~/.rvm/gems/ruby-1.9.2-p290/gems/mysql2-0.3.11/lib/mysql2/mysql2.bundle

I solved it (quickly) by just exporting the path to the MySQL library:

export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
  
# Licensing

This is just a demo, so realistically speaking, putting a license on this is a bit irrelevant. However, for the avoidance of doubt, this code is published under the Apache 2 license.