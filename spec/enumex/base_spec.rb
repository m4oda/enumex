require 'spec_helper'

RSpec.describe Enumex::Base, '#attach_to' do
  context 'when the first parameter is not an Enumerator instance' do
    it 'raises TypeError' do
      expect { described_class.new.attach_to(double) }.to raise_error(TypeError)
    end
  end
end

RSpec.describe Enumex::Base, '#run' do
  context 'when the instance has no enumerator' do
    it 'does not raise error' do
      expect { described_class.new.run }.not_to raise_error
    end

    it 'returns nil' do
      expect(described_class.new.run).to be_nil
    end
  end

  context 'when the instance has an enumerator' do
    let(:instance) do
      described_class.new.tap do |enm|
        enm.instance_eval { instance_variable_set(:@enumerator, (1..20).map) }
      end
    end

    context 'when the instance has a block' do
      before do
        instance.instance_eval { instance_variable_set(:@block, ->(n) { n }) }
      end

      it 'does not return an enumerator' do
        expect(instance.run).not_to be_an_instance_of(Enumerator)
      end
    end

    context 'when the instance has no block' do
      it 'returns an enumerator' do
        expect(instance.run).to be_an_instance_of(Enumerator)
      end
    end
  end
end
