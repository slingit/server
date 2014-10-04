class CreateUsers < ActiveRecord::Migration
  def change
  	enable_extension 'uuid-ossp'
    create_table :users, id: :uuid do |t|
    	t.belongs_to :group
      t.timestamps
    end
  end
end
