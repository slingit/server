class DevicesController < ApplicationController
  def create
    @device = Device.new(device_params)
    status = @device.save ? 201 : 422
    render nothing: true, status: status
  end

  private

  def device_params
    params.require(:devices).permit(:id, :secret)
  end
end
