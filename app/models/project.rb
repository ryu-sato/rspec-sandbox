# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  lock_version :integer
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#
# Indexes
#
#  index_projects_on_name     (name)
#  index_projects_on_user_id  (user_id)
#

class Project < ApplicationRecord
  belongs_to :user
  has_many :notes

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
