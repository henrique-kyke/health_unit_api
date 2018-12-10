require 'rails_helper'

RSpec.describe UbsCsvReader do
  before(:all) do
    @reader = described_class.new
  end

  context 'setting up' do
    it 'should starts with source_data' do
      expect(@reader.source_data).to be_present
    end
  end

  context 'reading' do
    it 'should returns a body' do
      expect(@reader.read).to be_an_instance_of(Array)
      expect(@reader.body).not_to be_empty
    end
  end
end