class Student < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :user, optional: true
  belongs_to :teacher, -> { includes :user }, optional: true
  belongs_to :class_room

  belongs_to :department

  # For students and subjects associations
  has_many :student_subjects
  has_many :subjects, through: :student_subjects

  # For students and scores
  has_many :scores, dependent: :restrict_with_error

  # VALIDATIONS
  validates :first_name, presence: true
  validates :last_name, presence: true


  # SCOPES
  def self.all_students(class_room_id)
    where('class_room_id = ?', class_room_id)
  end




  # SCOPES
  private
    def self.total_students
      count(:id)
    end


end
