class AddingUniqueToEmail < ActiveRecord::Migration[6.1]
  change_column :users, :email, :string, index: { unique: true }
end
