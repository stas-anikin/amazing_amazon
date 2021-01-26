class CreateTagsForProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :tags_for_products do |t|
      t.string :name
      t.timestamps
    end
  end
end
