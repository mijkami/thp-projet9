require_relative '../lib/crypto_scrapper'

describe 'crypto_scrapper' do
  it 'should return an array of hashes' do
    expect(crypto_scrapper.class).to eq(Array)
  end

  describe 'the hash must not be empty' do
    it 'should not be empty' do
      expect(crypto_scrapper.size).to be > 0
    end
  end
end
