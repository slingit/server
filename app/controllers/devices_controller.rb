class DevicesController < ApplicationController
  include Authentication
  include ErrorHandling
  include ForceJSON

  before_action :authenticate, only: [:index, :show]

  def index
    @devices = @authenticated_device.group.devices
    render :index
  end

  def show
    @device = Device.find_by(id: params[:id])
    if @device
      render :show, status: 200
    else
      render nothing: true, status: 404
    end
  end

  def create
    @device = Device.new(create_params)
    if @device.save
      render :show, status: 201
    else
      render nothing: true, status: 422
    end
  end

  def update
    @device = Device.find_by(id: params[:id])
    status = @device.update(update_params) ? 200 : 422
    render nothing: true, status: status
  end

  private

  def create_params
    result = params.require(:devices).permit(:id, :secret)
    if group_id = params[:devices][:links].try(:[], :group)
      result[:group_id] = group_id
    end
    result
  end

  def update_params
    { group_id: params.require(:devices)[:links][:group] }
  end
end
