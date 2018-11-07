# == Schema Information
#
# Table name: notes
#
#  id           :integer          not null, primary key
#  lock_version :integer
#  message      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  project_id   :integer
#  user_id      :integer
#
# Indexes
#
#  index_notes_on_project_id  (project_id)
#  index_notes_on_user_id     (user_id)
#

class Note < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :user, optional: true

  validates :message, presence: true

  scope :search, ->(term) {
    where("LOWER(message) LIKE ?", "%#{term.downcase}%")
  }
end
