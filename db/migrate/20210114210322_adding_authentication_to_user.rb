class AddingAuthenticationToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_digest, :string
    add_reference :reviews, :user, foreign_key: true
    add_reference :products, :user, foreign_key: true
  end
end
