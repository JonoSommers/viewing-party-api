class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from StandardError, with: :start_time_after_end_time

    private 

    def render_unprocessable_entity(exception)
        render json: ErrorSerializer.format_error(ErrorMessage.new(exception.message, 422)), status: :unprocessable_content
    end

    def start_time_after_end_time(exception)
        render json: ErrorSerializer.format_error(ErrorMessage.new(exception.message, 422)), status: :unprocessable_content
    end
end
