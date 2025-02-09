class ApplicationController < ActionController::API
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from StandardError, with: :handle_sad_path_error

    private 

    def render_unprocessable_entity(exception)
        render json: ErrorSerializer.format_error(ErrorMessage.new(exception.message, 422)), status: :unprocessable_content
    end

    def handle_sad_path_error(exception)
        render json: ErrorSerializer.format_error(ErrorMessage.new(exception.message, 422)), status: :unprocessable_content
    end
end
