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

class Diff < ApplicationRecord
end
