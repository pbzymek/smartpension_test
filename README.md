# Webserver logs parser
To install the required dependencies

run: `bundle install`

To run the test suite: `rspec`

Run parser with default log file: 

`./parser.rb webserver.log`

To run parser with verbose parameter list: 

`./parser.rb --file_name webserver.log --file_reader plain_line --processor_type most_unique_visits` 

To run parser with verbose parameter list against json log:

`./parser.rb --file_name webserver.log.json --file_reader json --processor_type most_unique_visits`

To get option parameter list: `./parser.rb -h`
