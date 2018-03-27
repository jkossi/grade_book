class Teacher < ApplicationRecord
  self.primary_key = 'user_id'
  belongs_to :user, foreign_key: 'user_id'

  # A class teacher can create at least one student
  has_many :students, dependent: :restrict_with_error

  has_many :student_subjects, dependent: :restrict_with_error

  has_one :class_room

  # PUBLIC INSTANCE METHODS
end
