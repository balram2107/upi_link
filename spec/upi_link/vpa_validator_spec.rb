require "spec_helper"

RSpec.describe UpiLink::VpaValidator do
  it "validates correct VPAs" do
    expect(described_class.valid?("name@okhdfcbank")).to be true
    expect(described_class.valid?("test.user@ybl")).to be true
    expect(described_class.valid?("9876543210@paytm")).to be true
  end

  it "rejects invalid VPAs" do
    expect(described_class.valid?("noatsign")).to be false
    expect(described_class.valid?("has space@ybl")).to be false
    expect(described_class.valid?(nil)).to be false
    expect(described_class.valid?("")).to be false
  end
end