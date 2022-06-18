class UsersController < ApplicationController
  before_action :set_target_user

  def touch_relationship
    manager = RelationshipManager.new(current_user: @current_user, target_user: @target_user)

    if manager.process
      head :ok
    else
      render json: { errors: manager.errors }, status: :bad_request
    end
  end

  private

  def set_target_user
    @target_user = User.find_by(id: params[:target_user_id])
    render json: { errors: 'target user not found' }, status: :not_found unless @target_user
  end
end
