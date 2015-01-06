class DevicesController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :set_format
  before_action :authenticate_device!, only: [:index, :show]

  rescue_from "ActiveRecord::RecordNotUnique" do |error|
    render nothing: true, status: 422
  end

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

  def authenticate_device!
    @authenticated_device = authenticate_with_http_basic do |id, secret|
      Device.find_by(id: id).authenticate(secret)
    end

    unless @authenticated_device
      return render nothing: true, status: 401
    end
  end

  def set_format
    request.format = :json
  end

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
