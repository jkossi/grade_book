class Department < ApplicationRecord

  # ASSOCIATIONS
  has_many :students

  has_many :class_rooms

  # An admin can create at least one department
  belongs_to :admin, class_name: 'User',
                     foreign_key: 'user_id'

  # A department have at least one department in
  # department_teachers table
  has_many :department_teachers

  # A department can have at least on teacher via
  # department_teachers table
  has_many :teachers, through: :department_teachers,
                      source: 'User'

  # A department have at least one department/subject relationship in
  # department_subjects table
  has_many :department_subjects

  # A department have at least one subjects in
  # department_subjects table
  has_many :subjects, through: :department_subjects


  # VALIDATIONS
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  # SCOPES
  def self.total_departments
    count(:id)
  end

end
