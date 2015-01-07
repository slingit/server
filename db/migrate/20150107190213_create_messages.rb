class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages, id: :uuid do |t|
      t.column :content, :bytea
      t.text :media_type
      t.text :name

      t.timestamps null: false
    end
  end
end
