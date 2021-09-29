
module LogEntries
  class  Parser
    def initialize(entry)
      raise NotImplementedError
    end

    def parse
      validate

      LogEntry.new(*log_entry_fields)
    end

    def log_entry_fields
      raise NotImplementedError
    end

    def valid?
      raise NotImplementedError
    end

    def validate
      raise NotImplementedError
    end
  end
end