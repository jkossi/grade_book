class Score < ApplicationRecord
  belongs_to :subject
  belongs_to :student
  belongs_to :user
  belongs_to :academic_session
end
