class AddHitCount < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :hit_count, :integer
  end
end
