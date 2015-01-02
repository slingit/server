class Group
  include ActiveModel::Model

  attr_accessor :id

  def devices
    Device.where(group_id: id)
  end
end
