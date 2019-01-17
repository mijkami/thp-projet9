require_relative '../lib/mairies'

describe "get_townhall_list" do
	it "should return an array" do
		expect(get_townhall_list.class).to eq(Array)
	end

	it "should be not empty" do
		expect(get_townhall_list.size).to be > 0
	end
end

describe "get_townhall_email" do
	it "should return an email when given a partail URL" do
		expect(get_townhall_email("/95/neuville-sur-oise.html").class).to eq(String)
	end

	it "should return an email when given a partail URL" do
		expect(get_townhall_email("/95/neuville-sur-oise.html").size).to be > 0
	end
end