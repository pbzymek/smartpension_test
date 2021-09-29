require 'spec_helper'

require_relative '../../lib/file_readers/json_reader'
require_relative '../../lib/file_readers/plain_line_reader'
require_relative '../../lib/interactors/logs_parser'
require_relative '../../lib/log_entries/json_parser'
require_relative '../../lib/log_entries/plain_line_parser'
require_relative '../../lib/processors/unique_most_visits_processor'
require_relative '../../lib/presenters/unique_most_visits_presenter'
require_relative '../../lib/log_entry'

describe LogsParser do
  describe '#perform' do
    context 'when using plain file log and most unique visits processor' do
      let(:file_reader) { FileReaders::PlainLineReader.new('spec/fixtures/webserver.log') }
      let(:log_entry_processors) { [Processors::UniqueMostVisitsProcessor.new] }
      let(:expected_output) do
        <<-PRESENTER_OUTPUT
/help_page/1 23 unique views
/contact 23 unique views
/home 23 unique views
/index 23 unique views
/about/2 22 unique views
/about 21 unique views
        PRESENTER_OUTPUT
      end

      subject do
        LogsParser.call(file_reader: file_reader, log_entry_processors: log_entry_processors)
      end

      it { expect { subject.present }.to output(expected_output).to_stdout }
    end

    context 'when using json file log and most unique visits processor' do
      let(:file_reader) { FileReaders::JsonReader.new('spec/fixtures/webserver.log.json') }
      let(:log_entry_processors) { [Processors::UniqueMostVisitsProcessor.new] }
      let(:expected_output) do
        <<-PRESENTER_OUTPUT
/help_page/1 23 unique views
/contact 23 unique views
/home 23 unique views
/index 23 unique views
/about/2 22 unique views
/about 21 unique views
        PRESENTER_OUTPUT
      end

      subject do
        LogsParser.call(file_reader: file_reader, log_entry_processors: log_entry_processors)
      end

      it { expect { subject.present }.to output(expected_output).to_stdout }
    end
  end
end