require 'spec_helper'

require_relative '../../lib/log_entries/plain_line_parser'
require_relative '../../lib/log_entry'

describe LogEntries::PlainLineParser do
  describe "#parse" do
    subject { described_class.new(line).parse }

    context 'when the line is correct' do
      let(:line) { '/home 646.865.545.408' }


      it { expect(subject).to be_a(LogEntry) }
      it { expect(subject.path).to eq '/home' }
      it { expect(subject.ip).to eq '646.865.545.408' }
    end

    context 'when the line is incorrect' do
      context 'when the line has one column' do
        let(:line) { '/home646.865.545.408' }

        it { expect { subject }.to raise_error(ArgumentError) }
      end

      context 'when the line has more than two columns' do
        let(:line) { '/home 646.865.545.408 AdditionalInfo' }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end
end
