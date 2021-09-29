require 'fast_jsonparser'
require_relative 'reader'
require_relative '../log_entries/json_parser'

module FileReaders
  class JsonReader < Reader
    def each_entry
      # TODO: add error handling
      # TODO: for extremely big files use streaming or Oj::Saj parser
      FastJsonparser.load(@file_path).each do |entry|
        yield LogEntries::JsonParser.new(entry).parse
      end
    end
  end
end
