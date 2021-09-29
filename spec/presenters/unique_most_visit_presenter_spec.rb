require 'spec_helper'

require_relative '../../lib/presenters/unique_most_visits_presenter'

describe Presenters::UniqueMostVistsPresenter do
  describe '#present' do
    subject { described_class.new(results) }

    context 'when there are results' do
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

      let(:results) do
        {
          '/help_page/1' => 23.times.map { |i| IPAddr.new(i, Socket::AF_INET).to_s },
          '/contact' => 23.times.map { |i| IPAddr.new(i, Socket::AF_INET).to_s },
          '/home' => 23.times.map { |i| IPAddr.new(i, Socket::AF_INET).to_s },
          '/index' => 23.times.map{ |i| IPAddr.new(i, Socket::AF_INET).to_s },
          '/about/2' => 22.times.map{ |i| IPAddr.new(i, Socket::AF_INET).to_s },
          '/about' => 21.times.map{ |i| IPAddr.new(i, Socket::AF_INET).to_s }
        }
      end

      it { expect { subject.present }.to output(expected_output).to_stdout }
    end

    context 'when results are empty' do
      let(:results) { Hash.new }
      let(:expected_output) { '' }

      it { expect { subject.present }.to output(expected_output).to_stdout }
    end

    context 'when results are incorrect data structure' do

    end
  end
end