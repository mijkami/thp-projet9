require_relative '../lib/crypto_scrapper'

describe "crypto_scrapper" do
	it "should return an array of hashes" do
		expect(crypto_scrapper.class).to eq(Array)
	end

	describe "the first item must be BTC" do |variable|
	it "should return BTC" do
		expect(crypto_scrapper[0][0]).to eq('BTC')
	end
end

