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
  pending "add some examples to (or delete) #{__FILE__}"
end
