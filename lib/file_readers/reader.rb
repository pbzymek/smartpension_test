module FileReaders
  class Reader
    attr_reader :file_path

    def initialize(path)
      @file_path = path
      raise ArgumentError, 'File does not exist' if !File.file?(@file_path)
    end

    def each_entry
      raise NotImplementedError
    end
  end
end
