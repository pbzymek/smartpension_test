require_relative 'parser'

module LogEntries
  class JsonParser < Parser

    attr_accessor :json_entry

    LOG_ENTRY_ATTRIBUTES = %i[path ip]

    def initialize(entry)
      # TODO: add more validation
      @json_entry = entry
    end

    def log_entry_fields
      [log_entry_attributes[:path], log_entry_attributes[:ip]]
    end

    def valid?
      json_entry.kind_of?(Hash) && has_required_attributes?
    end

    def log_entry_attributes
      @log_entry_attributes ||= json_entry.slice(*LOG_ENTRY_ATTRIBUTES)
    end

    def validate
      unless valid?
        raise ArgumentError,"Expected line to have 2 attributes, got: #{log_entry_attributes.size}"
      end
    end

    def has_required_attributes?
      !log_entry_attributes[:path].nil? && !log_entry_attributes[:ip].nil?
    end
  end
end