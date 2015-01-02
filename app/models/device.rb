class Device < ActiveRecord::Base
  has_secure_password
  alias secret= password=
  alias valid_secret? authenticate

  def group
    Group.new(id: group_id)
  end
end
