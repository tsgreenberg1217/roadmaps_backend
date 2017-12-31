class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.string :url
      t.string :desc
      t.integer :activity_id

      t.timestamps
    end
  end
end
