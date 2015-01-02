class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices, id: :uuid do |t|
      t.text :password_digest
      t.uuid :group_id
    end
  end
end
