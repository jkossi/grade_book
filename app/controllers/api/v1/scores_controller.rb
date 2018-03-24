module Api::V1
  class ScoresController < Api::V1::BaseController
    def new
      @score = Score.new
    end
  end
end

