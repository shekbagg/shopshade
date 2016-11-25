class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :store
      t.string :name
      t.string :link

      t.timestamps
    end
  end
end
