class Student < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :user, optional: true
  belongs_to :teacher, optional: true
  belongs_to :class_room

  belongs_to :department

  # For students and subjects associations
  has_many :student_subjects
  has_many :subjects, through: :student_subjects

  # For students and scores
  has_many :scores, dependent: :destroy

  # VALIDATIONS
  validates :first_name, presence: true
  validates :last_name, presence: true


  # SCOPES
  private
  def self.total_students
    count(:id)
  end
end
