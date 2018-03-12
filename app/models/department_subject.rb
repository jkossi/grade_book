class DepartmentSubject < ApplicationRecord
  # An admin can create at least one
  # department_subjects relationship
  belongs_to :user

  belongs_to :department
  belongs_to :subject
end
