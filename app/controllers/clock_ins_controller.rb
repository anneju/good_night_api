class ClockInsController < ApplicationController
  def index
    limit = params.fetch(:limit, 10)
    offset = params.fetch(:offset, 0)

    @clock_ins = @current_user.clock_ins.order(created_at: :desc).limit(limit).offset(offset)
  end

  def create
    @clock_in = @current_user.clock_ins.new

   if @clock_in.save
      head :created
   else
      render json: { errors: @clock_in.errors.messages }, status: :bad_request
   end
  end
end
