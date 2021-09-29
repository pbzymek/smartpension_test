require 'set'

module Processors
  class UniqueMostVisitsProcessor

    attr_reader :uniq_visits

    def initialize
      @uniq_visits = {}
    end

    def process(log_entry)
      uniq_visits[log_entry.path] ||= ::Set.new
      uniq_visits[log_entry.path] << log_entry.ip
    end

    def present
      ::Presenters::UniqueMostVistsPresenter.new(uniq_visits).present
    end
  end
end