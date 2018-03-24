module Api::V1
  class SubjectsController < Api::V1::BaseController
    before_action :is_admin

    helper_method :count_subjects, :subjects

    def new
      @subject = Subject.new
    end

    def index

    end

    def show

    end

    def create
      @subject = current_user.subjects.build(new_subject_params)

      if @subject.save
        redirect_to new_staff_subject_url(current_user), notice: 'New subject added'
      else
        render 'api/v1/subjects/new'
      end
    end

    def update
      @subject = current_user.subjects.find_by_id(params[:id])

      redirect_if_no_subject(@subject, current_user, 'update')

      if @subject.update(new_subject_params)
        redirect_to new_staff_subject_url, notice: "#{@subject.name} updated successfully"
      else
        render 'api/v1/subjects/edit'
      end
    end

    def edit
      @subject = current_user.subjects.find_by_id(params[:id])
      redirect_if_no_subject(@subject, current_user, 'edit')
    end

    def destroy
      @subject = current_user.subjects.find_by_id(params[:id])
      redirect_if_no_subject(@subject, current_user, 'delete')
      if @subject.destroy
        redirect_to new_staff_subject_url(current_user), notice: "#{@subject.name} is deleted successfully"
      else
        render 'api/v1/subjects/new'
      end
    end

    private
      # PARAMS
      def new_subject_params
        params.require(:subject).permit(:name)
      end

      # INSTANCE METHODS
      def is_admin
        unless helpers.is_admin?(current_user)
          redirect_to root_url, notice: 'You are not authorized to view this page'
        end
      end

      def redirect_if_no_subject(subject, current_user, event_name)
        unless subject.present?
          redirect_to new_staff_subject_url(current_user), alert: "You are not authorized to #{event_name} this subject" and return
        end
      end


      # VIEW HELPER METHODS - This method are available in the views as: count_subjects, subjects
      def count_subjects
        Subject.count(:id)
      end

      def subjects
        Subject.all
      end

  end
end
