require 'spec_helper'
require_relative '../../lib/file_readers/json_reader'
require_relative '../../lib/log_entries/json_parser'
require_relative '../../lib/log_entry'

describe FileReaders::JsonReader do

  subject { described_class.new(file_path) }

  describe '.new' do
    context 'when file exists' do
      let(:file_path) { 'spec/fixtures/json_log.json' }
      it { expect(subject).to be_a(FileReaders::JsonReader) }
    end

    context 'when file_path is a directory' do
      let(:file_path) { 'spec/fixtures/' }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context 'when file does not exist' do
      let(:file_path) { 'spec/fixtures/no_file.log' }

      it { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe '#each_entry' do
    let(:file_path) { 'spec/fixtures/json_log.json'  }

    it 'reads the file and create 7 log entries' do
      subject.each_entry do |line|
        expect(line).to be_a(LogEntry)
      end
    end
  end
end
