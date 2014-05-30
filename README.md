wintac
======

wintac web portal 

1. Prior to initial run:
  * Make sure Postgresql is intalled
  * There is a `postgres` user with the password of `postgres`
2. Initial run:
  * Get the gems for the project
    * `bundle install`
  * Create the database
    * `rake db:create`
  * Migrate the database
    * `rake db:migrate`
3. Start server
  * `rails server`
4. View in browser
  * <http://localhost:3000>

