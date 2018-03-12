class ClassRoom < ApplicationRecord
  # ASSOCIATIONS

  # An admin can creates at least one class room
  belongs_to :user

  # A class room can be assigned to only one class teacher
  belongs_to :teacher

  belongs_to :department

  has_many :students

  # VALIDATIONS
  validates :teacher_id, uniqueness: true



end
