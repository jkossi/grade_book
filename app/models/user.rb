class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # VAIDATIONS
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  # ASSOCIATIONS
  # A user who has a role as a teacher can be a class teacher
  # This is used to know the class teachers
  has_one :teacher, dependent: :destroy

  # An admin can create at least one students
  has_many :students, -> { where role: 'admin' }

  # An admin can create at least one unique classroom
  has_many :class_rooms,
           -> { where role: 'admin' }

  # For Administrator can create many teachers
  has_many :teachers, class_name: 'User',
                      foreign_key: 'user_id',
                      dependent: :destroy

  # An admin can create at least one department
  # and subject relationships
  has_many :department_subjects

  has_many :student_subjects

  # Every teacher is created by an Administrator
  belongs_to :admin, class_name: 'User'

  # For departments and teachers
  has_many :department_teachers
  has_many :departments, through: :department_teachers

  # For teachers and subjects
  has_many :subject_teachers
  has_many :subjects, through: :subject_teachers

  # An Admin can create many subjects
  has_many :subjects, dependent: :destroy

  # A teacher can teach at least one subject
  # has_many :assigned_subjects, class_name: 'Subject', foreign_key: 'user_id'
end
