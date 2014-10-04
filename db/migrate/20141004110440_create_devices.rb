class CreateDevices < ActiveRecord::Migration
  def change
  	enable_extension 'uuid-ossp'
    create_table :devices, id: :uuid do |t|
    	t.text :type
    	t.text :token
    	t.belongs_to :group
      t.timestamps
    end
  end
end
