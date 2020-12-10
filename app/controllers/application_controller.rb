class ApplicationController < ActionController::API
  rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ::ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_not_found
    head :not_found
  end

  def record_invalid(error)
    render json: error.record.errors, status: :unprocessable_entity
  end
end
