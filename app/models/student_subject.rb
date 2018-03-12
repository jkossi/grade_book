class StudentSubject < ApplicationRecord
  belongs_to :student
  belongs_to :subject
  belongs_to :user
  belongs_to :teacher
end
