require 'application_helper'

module Api::V1
  class DepartmentsController < Api::V1::BaseController
    before_action :is_admin

    helper_method :total_departments, :departments

    def new
      @department = Department.new
    end

    def index

    end

    def create

      unless helpers.is_admin?(current_user)
        redirect_to root_url, alert: 'You are not authorized to add departments'
      end

      @department = current_user.new_departments.build(department_params)

      if @department.save
        redirect_to new_staff_department_url, notice: 'New department added'
      else
        render 'api/v1/departments/new'
      end
    end

    def update
      @department = current_user.new_departments.find_by_id(params[:id])

      if @department.update(department_params)
        redirect_to new_staff_department_url(current_user), notice: "#{@department.name} updated successfuly"
      else
        render 'api/v1/departments/edit'
      end

    end

    def edit
      @department = current_user.new_departments.find_by_id(params[:id])

      redirect_if_no_department(@department, current_user, 'edit')
    end

    def destroy
      @department = current_user.new_departments.find_by_id(params[:id])

      redirect_if_no_department(@department, current_user, 'delete')

      if @department.destroy
        redirect_to new_staff_department_url(current_user), notice: "#{@department.name} is deleted successfully"
      else
        render 'api/v1/departments/new'
      end
    end

    def show

    end

    private
      def is_admin
        unless helpers.is_admin?(current_user)
          redirect_to root_url, alert: 'You are not authorized to view this page'
        end
      end

      def department_params
        params.require(:department).permit(:name)
      end

      def redirect_if_no_department(department, current_user, event_name)
        unless department.present?
          redirect_to new_staff_department_url(current_user), alert: "You are not authorized to #{event_name} this department" and return
         end
      end

      # HELPER METHODS FOR VIEWS
      def total_departments
        Department.count(:id)
      end

      def departments
        Department.all
      end

  end
end

