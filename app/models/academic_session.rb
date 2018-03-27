class AcademicSession < ApplicationRecord
  # ASSOCIATIONS
  belongs_to :user
  has_many :scores, dependent: :restrict_with_error

  # VALIDATIONS
  validates :term, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  # SCOPES
  def self.total_academic_sessions
    count(:id)
  end
end
