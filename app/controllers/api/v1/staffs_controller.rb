module Api::V1
  class StaffsController < Api::V1::BaseController
    before_action :is_admin
    helper_method :count_classroom, :classrooms

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

      redirect_if_no_staff(@user, current_user, 'edit')

    end

    def update
      @user = current_user.staffs.find_by_id(params[:id])

      redirect_if_no_staff(@user, current_user, 'edit')

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
    end

    private
      # PARAMS
      def new_staff_params
        params.require(:user).permit(:email, :first_name, :gender, :phone, :last_name, :password, :role_id, :user_id)
      end

      def new_classroom_params
        params.require(:class_room).permit(:name, :teacher_id, :department_id)
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
          redirect_to root_url, notice: 'You are not authorized to view this page'
        end
        staffs_url
      end

      def redirect_if_no_item(item, url, event_name, model)
        unless staff.present?
          redirect_to url, alert: "You are not authorized to #{event_name} this #{model}: #{staff.first_name.capitalize}" and return
        end
      end

  end
end


