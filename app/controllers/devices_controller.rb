class DevicesController < ApplicationController
  before_action :set_format

  def create
    @device = Device.new(device_params)
    if @device.save
      render :show, status: 201
    else
      render nothing: true, status: 422
    end
  end

  private

  def set_format
    request.format = :json
  end

  def device_params
    params.require(:devices).permit(:id, :secret)
  end
end
