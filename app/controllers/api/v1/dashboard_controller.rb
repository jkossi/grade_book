module Api::V1
  class DashboardController < Api::V1::BaseController

    def index
      total_students = 0

      if helpers.is_admin?(current_user)
        total_students = Student.total_students
      else
        classroom = ClassRoom.find_by_teacher_id(current_user.id)
        if classroom.present?
          total_students = Student.all_students(classroom.id).count
        else
          total_students = nil
        end
      end

      render locals: {
          total_staffs: User.total_staffs,
          total_students: total_students,
          total_subjects: Subject.total_subjects,
          total_classrooms: ClassRoom.total_classrooms,
          total_departments: Department.total_departments,
          total_academic_sessions: AcademicSession.total_academic_sessions
      }
      end
    end
end

