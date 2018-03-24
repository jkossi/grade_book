class ClassRoom < ApplicationRecord
  # ASSOCIATIONS

  # An admin can creates at least one class room
  belongs_to :user

  # A class room can be assigned to only one class teacher
  belongs_to :teacher

  belongs_to :department

  has_many :students

  # VALIDATIONS
  validates :teacher_id, uniqueness: { message: 'already assigned to a class' }
  validates :name, presence: true, uniqueness: { case_sensitive: false }


  # SCOPES
  def self.total_classrooms
    count(:id)
  end


end
