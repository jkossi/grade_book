class DepartmentTeacher < ApplicationRecord
  belongs_to :teacher, class_name: 'User',
                       foreign_key: 'user_id'
  belongs_to :department
end
