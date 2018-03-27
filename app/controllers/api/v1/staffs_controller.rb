module Api::V1
  class StaffsController < Api::V1::BaseController
    before_action :is_admin, except: [:students, :new_student, :create_students, :destroy_student, :update_student, :edit_student]
    before_action :is_class_teacher_or_admin, only: [:students, :new_student, :update_student, :create_students, :edit_student, :destroy_student]
    helper_method :count_classroom, :classrooms, :teacher_exists?

    def new
      @user = User.new
    end

    def create
      @user = current_user.staffs.build(new_staff_params)
      if @user.save
        redirect_to staffs_url, notice: 'New staff added'
      else
        render 'api/v1/staffs/new'
      end
    end

    def edit
      @user = current_user.staffs.find_by_id(params[:id])

      redirect_if_no_item(@user, current_user, 'edit', 'staff')

    end

    def update
      @user = current_user.staffs.find_by_id(params[:id])

      redirect_if_no_item(@user, current_user, 'edit', 'staff')

      if @user.update(new_staff_params)
        redirect_to staffs_url, notice: 'Staff updated successfully'
      else
        render 'api/v1/staffs/edit'
      end
    end

    def destroy
      @user = current_user.staffs.find_by_id(params[:id])

      redirect_if_no_item(@user, staffs_url, 'delete', 'staff')
      if @user.destroy
        redirect_to staffs_url, notice: "#{@user.first_name.capitalize} is deleted successfully"
      else
        render 'api/v1/staffs/index'
      end
    end

    def show
    end

    def index
      @users = User.order('created_at desc')
    end

    # CLASS ROOM
    def class_rooms
      @classrooms = ClassRoom.all
    end

    def destroy_classroom
      @classroom = current_user.class_rooms.find_by_id(params[:id])
      redirect_if_no_item @classroom, class_rooms_staffs_path, 'delete', 'class'
      if @classroom.destroy
        redirect_to class_rooms_staffs_path, notice: "#{@classroom.name} is deleted successfully"
      else
        render 'api/v1/staffs/class_rooms'
      end
    end


    def new_classroom
      @classroom = ClassRoom.new
    end

    def create_classrooms
      payload = new_classroom_params
      user = User.find_by_id(payload[:teacher_id]) || redirect_to(root_url, alert: 'User not found')
      teacher = user.build_teacher(is_class_teacher: true)
      if teacher.save
        @classroom = ClassRoom.new(
            name: payload[:name],
            user_id: current_user.id,
            teacher_id: payload[:teacher_id],
            department_id: payload[:department_id]
        )

        if @classroom.save
          redirect_to new_classroom_staff_path, notice: "New class: #{@classroom.name}  created successfully"
        else
          render 'api/v1/staffs/new_classroom'
        end
      else
        redirect_to root_url, alert: 'Failed to save associated record, try again...'
      end
    end

    def edit_classroom
      @classroom = current_user.class_rooms.find_by_id(params[:id])
      redirect_if_no_item @classroom, class_rooms_staffs_path, 'edit', 'class'
    end

    def update_classroom
      @classroom = current_user.class_rooms.find_by_id(params[:id])
      redirect_if_no_item @classroom, class_rooms_staffs_path, 'update', 'class'

      existing_teacher_id = @classroom.teacher_id

      if teacher_exists?(existing_teacher_id)
        Teacher.destroy(existing_teacher_id)
      end

      unless teacher_exists?(params[:class_room][:teacher_id])
        new_teacher = Teacher.new(user_id: params[:class_room][:teacher_id], is_class_teacher: true)
        new_teacher.save
      end

      if @classroom.update(new_classroom_params)
        redirect_to class_rooms_staffs_path, notice: "#{@classroom.name} is updated successfully"
      else
       render 'api/v1/staffs/edit_classroom'
      end
    end

    # STUDENTS
    def students
      @students = nil
      if helpers.is_admin?(current_user)
        @students = Student.all
      else
        # teacher = Teacher.find_by_user_id(current_user.id)
        classroom = ClassRoom.find_by_teacher_id(current_user.id)
        @students = Student.all_students(classroom.id)
      end
    end


    def new_student
      @student = Student.new
    end

    # TOdo: Issues with created by not showing for a class teacher
    def create_students
      @student = nil

      if helpers.is_admin?(current_user)
        @student = current_user.students.build(new_student_params)
      else
        teacher = Teacher.find_by_user_id(current_user.id)
        @student = teacher.students.build(new_student_params)
      end

      classroom_id = params[:student][:class_room_id]
      classroom = ClassRoom.find_by_id(classroom_id)
      department_id = classroom.department.id
      @student.department_id = department_id

      if @student.teacher_id.present? && classroom.teacher_id != current_user.id
        redirect_to students_staffs_path, alert: "You are not the class teacher of: #{classroom.name}, so you can't add a student to this class." and return
      end

      if @student.save
        redirect_to students_staffs_path, notice: "#{@student.first_name.capitalize} added successfully"
      else
        render 'api/v1/staffs/new_student'
      end
    end

    def edit_student
      @student = Student.find_by_id(params[:id])
      redirect_if_no_item(@student, students_staffs_path, 'edit', 'student')
    end

    def update_student
      @student = Student.find_by_id(params[:id])
      redirect_if_no_item(@student, students_staffs_path, 'edit', 'student')

      classroom_id = params[:student][:class_room_id]
      classroom = ClassRoom.find_by_id(classroom_id)
      department_id = classroom.department.id
      @student.department_id = department_id


      if helpers.is_admin?(current_user)
        if @student.update(new_student_params)
          redirect_to students_staffs_path, notice: "#{@student.first_name} updated successfully."
        else
          render 'api/v1/staffs/edit_student'
        end
      else
        if classroom.teacher_id != current_user.id
          redirect_to students_staffs_path, alert: "You are not the class teacher of: #{classroom.name}, so you can't update the student class to #{classroom.name}" and return
        end

        if @student.update(new_student_params)
          redirect_to students_staffs_path, notice: "#{@student.first_name} updated successfully."
        else
          render 'api/v1/staffs/edit_student'
        end
      end
    end

    def destroy_student
      @student = Student.find_by_id(params[:id])
      redirect_if_no_item(@student, students_staffs_path, 'edit', 'student')

      unless helpers.is_admin?(current_user)
        redirect_to students_staffs_path, alert: 'You are not authorized to delete a student' and return
      end

      if @student.destroy
        redirect_to students_staffs_path, notice: "#{@student.first_name} is deleted successfully."
      else
        render 'api/v1/staffs/students'
      end


    end


    private
      # PARAMS
      def new_staff_params
        params.require(:user).permit(:email, :first_name, :gender, :phone, :last_name, :password, :role_id, :user_id)
      end

      def new_classroom_params
        params.require(:class_room).permit(:name, :teacher_id, :department_id)
      end

      def new_student_params
        params.require(:student).permit(:first_name, :last_name, :middle_name, :gender, :class_room_id)
      end

      # HELPER METHODS
      def staffs
        User.all.order('created_at desc')
      end

      def total_staffs
        User.count(:id)
      end

      def classrooms
        ClassRoom.all
      end

      def count_classroom
        ClassRoom.count(:id)
      end

      # INSTANCE METHODS
      def is_admin
        unless helpers.is_admin?(current_user)
          redirect_to root_url, alert: 'You are not authorized to view this page'
        end
        # staffs_url
      end

      def is_class_teacher_or_admin
        unless helpers.is_admin?(current_user) || teacher_exists?(current_user.id)
          redirect_to root_url, alert: 'You are not authorized to view this page'
        end
      end

      def teacher_exists?(id)
        Teacher.exists?(id)
      end

      def redirect_if_no_item(item, url, event_name, model_name)
        unless item.present?
          redirect_to url, alert: "You are not authorized to #{event_name} this #{model_name}" and return
        end
      end

  end
end


