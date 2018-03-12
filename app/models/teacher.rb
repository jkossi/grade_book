class Teacher < ApplicationRecord
  self.primary_key = 'user_id'
  belongs_to :user

  # A class teacher can create at least one student
  has_many :students

  has_many :student_subjects

  has_one :class_room
end
