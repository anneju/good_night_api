class ClockInsController < ApplicationController
  before_action :clock_in_params, only: [:create]

  def index
    limit = params.fetch(:limit, 10)
    offset = params.fetch(:offset, 0)

    @clock_ins = @current_user.clock_ins.order(created_at: :desc).limit(limit).offset(offset)
  end

  def create
    @clock_in = @current_user.clock_ins.new(category: clock_in_params[:category])

   if @clock_in.save
      head :created
   else
      render json: { errors: @clock_in.errors.messages }, status: :bad_request
   end
  end

  private

  def clock_in_params
    params.require(:clock_in).permit(:category)
  end
end
