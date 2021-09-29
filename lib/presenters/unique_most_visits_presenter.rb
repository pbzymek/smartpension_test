require 'byebug'
module Presenters
  class UniqueMostVistsPresenter
    attr_reader :results

    def initialize(results)
      @results = results
    end

    def present
      prepare_results.each do |path, uniq_visits|
        puts "#{path} #{uniq_visits} unique views"
      end
    end

    def validate!
      results.each do |_path, ips|
        raise ArgumentError, 'Inccorect results data structure' if !ips.respond_to?(:size)
      end
    end

    private

    def prepare_results
      validate!
      results.map{|path, ips| [path, ips.size] }.sort{ |a, b| b.last <=> a.last }
    end
  end
end