require_relative 'parser'

module LogEntries
  class PlainLineParser < Parser
    COLUMN_SEPARATOR = ' '

    attr_accessor :line_columns

    def initialize(line)
      # TODO: add more validation
      @line_columns = line.to_s.split(COLUMN_SEPARATOR)
    end

    def log_entry_fields
      line_columns
    end

    def valid?
      !line_columns.nil? && line_columns.size == 2
    end

    def validate
      unless valid?
        raise ArgumentError,"Expected line to have 2 columns, got: #{@line_columns.size}"
      end
    end
  end
end