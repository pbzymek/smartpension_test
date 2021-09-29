#!/usr/bin/env ruby

require_relative 'lib/command_line/parser'
require_relative 'lib/file_readers/plain_line_reader'
require_relative 'lib/interactors/logs_parser'
require_relative 'lib/log_entries/plain_line_parser'
require_relative 'lib/processors/unique_most_visits_processor'
require_relative 'lib/presenters/unique_most_visits_presenter'
require_relative 'lib/log_entry'

options =  CommandLine::Parser.new(ARGV).parse

LogsParser.call(
  file_reader: options[:file_reader].new(options[:file_name]),
  log_entry_processors: options[:processor_types]
)
