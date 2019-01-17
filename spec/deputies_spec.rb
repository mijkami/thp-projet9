require_relative '../lib/deputies'

describe 'deputies' do
  it 'should return an array of hashes' do
    expect(deputies.class).to eq(Array)
  end

  describe 'the hash must not be empty' do
    it 'should not be empty' do
      expect(deputies.size).to be > 0
    end
  end
end
