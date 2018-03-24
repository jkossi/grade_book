module Api::V1
  class DashboardController < Api::V1::BaseController
    def index
      render locals: {
          total_staffs: User.total_staffs,
          total_subjects: Subject.total_subjects,
          total_students: Student.total_students,
          total_classrooms: ClassRoom.total_classrooms,
          total_departments: Department.total_departments,
          total_academic_sessions: AcademicSession.total_academic_sessions
      }
    end


  end
end

