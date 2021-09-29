require 'spec_helper'

require_relative '../../lib/log_entries/plain_line_parser'
require_relative '../../lib/log_entry'

describe LogEntries::JsonParser do
  describe "#parse" do
    subject { described_class.new(entry).parse }

    context 'when the entry is correct' do
      let(:entry) { { path: '/home', ip: '646.865.545.408' } }


      it { expect(subject).to be_a(LogEntry) }
      it { expect(subject.path).to eq '/home' }
      it { expect(subject.ip).to eq '646.865.545.408' }
    end

    context 'when the entry is incorrect' do
      context 'when the entry does not have the required attributes' do
        let(:entry) { { url: '/home', address: '646.865.545.408', source: 'some secret source' } }

        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end
end
