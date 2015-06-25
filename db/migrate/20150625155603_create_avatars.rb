class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.integer :user_id
      t.boolean :generated
      t.string :image_location

      t.timestamps null: false
    end
  end
end
