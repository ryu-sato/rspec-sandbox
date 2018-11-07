require 'rails_helper'

RSpec.describe Diff, type: :model do
  it "is valid with diff string" do
    diff = Diff.new(diff: "some diff")
    expect(diff).to be_valid
  end

  it "is invalid without diff string" do
    diff = Diff.new(diff: nil)
    expect(diff).to be_invalid
  end
end
