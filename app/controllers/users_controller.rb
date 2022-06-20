class UsersController < ApplicationController
  before_action :set_target_user, only: [:touch_relationship]

  def touch_relationship
    manager = RelationshipManager.new(current_user: @current_user, target_user: @target_user)

    if manager.process
      head :ok
    else
      render json: { errors: manager.errors }, status: :bad_request
    end
  end

  def followees_sleep_records
    limit = params.fetch(:limit, 10)
    offset = params.fetch(:offset, 0)

    @sleep_records = SleepRecord.includes(:user).where(user: @current_user.followees).last_7_days.order(duration: :desc).limit(limit).offset(offset)

    render "users/followees_sleep_records", status: :ok
  end

  private

  def set_target_user
    @target_user = User.find_by(id: params[:target_user_id])
    render json: { error: 'target user not found' }, status: :not_found unless @target_user
  end
end
