module Api::V1
  class AcademicSessionsController < Api::V1::BaseController
    before_action :is_admin

    def new
      @academic_session = AcademicSession.new
      render locals: {
          total_academic_sessions: AcademicSession.count,
          academic_sessions: AcademicSession.all
      }
    end

    def index
      @academic_sessions = AcademicSession.order('start_date asc')
    end

    def create
      @academic_session = current_user.academic_sessions.build(academic_session_params)
      if @academic_session.save
        redirect_to new_staff_academic_session_path, notice: 'New academic session created'
      else
        render 'api/v1/academic_sessions/new'
      end
    end

    def update
      @academic_session = current_user.academic_sessions.find_by_id(params[:id])
      redirect_if_no_acad_session(@academic_session, current_user, 'edit')

      if @academic_session.update(update_acad_session_params)
        redirect_to staff_academic_sessions_url(current_user), notice: 'Academic session updated successfully'
      else
        render 'api/v1/academic_sessions/edit'
      end
    end

    def edit
      @academic_session = current_user.academic_sessions.find_by_id(params[:id])
      redirect_if_no_acad_session(@academic_session, current_user, 'edit')
    end

    def show

    end

    def destroy
      @academic_session = current_user.academic_sessions.find_by_id(params[:id])
      redirect_if_no_acad_session(@academic_session, current_user, 'edit')

      if @academic_session.destroy
        redirect_to staff_academic_sessions_url(current_user), notice: "#{@academic_session.start_date.year}/#{@academic_session.end_date.year} academic session is deleted successfully"
      else
        render 'api/v1/academic_sessions/index'
      end
    end

    private
      # INSTANCE METHODS
      def is_admin
        unless helpers.is_admin?(current_user)
          redirect_to root_url, notice: 'You are not authorized to view this page'
        end
      end

      def redirect_if_no_acad_session(academic_session, current_user, event_name)
        unless academic_session.present?
          redirect_to staff_academic_sessions_url(current_user), alert: "You are not authorized to #{event_name} this academic session" and return
        end
      end


      # PARAMS
      def academic_session_params
        params.require(:academic_session).permit(:term, :year, :start_date, :end_date)
      end

      def update_acad_session_params
        params.require(:academic_session).permit(:term, :year, :start_date, :end_date, :closed)
      end


  end
end

