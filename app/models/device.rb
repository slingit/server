class Device < ActiveRecord::Base
  has_secure_password
  alias secret= password=

  def group
    Group.new(id: group_id) if group_id
  end

  def group=(group)
    self.group_id = group.id
  end
end
