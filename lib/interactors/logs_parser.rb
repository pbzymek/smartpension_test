require 'interactor'

class LogsParser

  include Interactor

  before do

  end

  def call
    context.file_reader.each_entry do |log_entry|
      context.log_entry_processors.each do |processor|
        processor.process(log_entry)
      end
    end

    context.log_entry_processors.map(&:present)
  end
end