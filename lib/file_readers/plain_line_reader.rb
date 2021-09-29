require_relative 'reader'

module FileReaders
  class PlainLineReader < Reader
    def each_entry
      File.readlines(file_path).each do |line|
        yield LogEntries::PlainLineParser.new(line).parse
      end
    end
  end
end
