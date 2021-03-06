class Subject < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :admin, class_name: 'User',
                     foreign_key: 'user_id'

  # For teachers and subjects
  has_many :subject_teachers
  has_many :teachers, through: :subject_teachers,
                      source: 'User'

  # For students and subjects
  has_many :student_subjects
  has_many :students, through: :student_subjects

  # A subject have at least one subject/department relationship in
  # department_subjects table
  has_many :department_subjects

  # A subject have at least one departments in
  # department_subjects table
  has_many :departments, through: :department_subjects

  # Scores and subjects
  has_many :scores, dependent: :destroy

  # SCOPES
  def self.recent
    order('created_at desc')
  end

  def self.total_subjects
    count(:id)
  end

  # VALIDATIONS
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, message: 'already exists' }
end
