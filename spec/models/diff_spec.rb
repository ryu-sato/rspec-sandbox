# == Schema Information
#
# Table name: diffs
#
#  id           :integer          not null, primary key
#  diff         :string           not null
#  lock_version :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Diff, type: :model do
  it "is valid with diff string" do
    diff = Diff.new(diff: "some diff")
    expect(diff).to be_valid
  end
end
