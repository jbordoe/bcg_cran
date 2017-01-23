**Initial setup**

Ensure hanami is installed:

`gem install hanami`

run the following commands:

`bundle install`

`bundle exec hanami db prepare`

`HANAMI_ENV=test bundle exec hanami db prepare`



**Downloading packages**

`bundle exec rake update_packages`



**Running the server**

`bundle exec hanami server`

head to `http://localhost:2300/packages` to see the list of downloaded packages
