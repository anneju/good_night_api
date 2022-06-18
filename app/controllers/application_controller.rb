class ApplicationController < ActionController::Base
  before_action :set_current_user
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def set_current_user
    @current_user ||= User.find(params[:user_id])
  end

  private

  def not_found(e)
    render json: {error: e.message}, status: :not_found
  end
end
