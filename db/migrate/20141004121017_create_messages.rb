class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.uuid :creator_id
    	t.text :content
      t.timestamps
    end
  end
end
