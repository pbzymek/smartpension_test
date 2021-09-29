require 'optparse'

require_relative '../file_readers/json_reader'
require_relative '../file_readers/plain_line_reader'

module CommandLine
  class Parser
    attr_reader :argv

    def initialize(argv)
      @argv = argv
    end

    def parse
      options = default_options

      OptionParser.new do |opt|
        opt.on('--file_name FILENAME', String, 'File to process <filename>') do |file_name|
          options[:file_name] = file_name
        end
        opt.on('--file_reader READERTYPE', String, 'File type [plain_file, json]') do |file_reader|
          options[:file_reader] = file_reader_map[file_reader]
        end
        opt.on('--processor_type processorType1,processorType2,processorTypeN',
               Array,
               'Processor to run against the file name [most_unique_visits]') do |processors|
          options[:processor_types] = processors.map { |processor| processors_map[processor].new }
        end
      end.parse!(argv)

      options[:file_name] = argv[0] if options[:file_name].nil?
      options[:processor_types] = [processors_map.default] if options[:processor_types].empty?

      options
    end

    def default_options
      {
        file_name: nil,
        file_reader: FileReaders::PlainLineReader,
        processor_types: [Processors::UniqueMostVisitsProcessor.new]
      }
    end

    def file_reader_map
      @file_reader_map ||= Hash.new()
      @file_reader_map['json'] ||= FileReaders::JsonReader
      @file_reader_map['plain_line'] ||= FileReaders::PlainLineReader
      @file_reader_map
    end

    def processors_map
      @processors_map ||= Hash.new(Processors::UniqueMostVisitsProcessor)
      @processors_map['most_unique_visits'] ||= Processors::UniqueMostVisitsProcessor
      @processors_map
    end
  end
end