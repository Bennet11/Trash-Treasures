class ChangePriceToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :posts, :price, :integer
    change_column :posts, :number, :integer
  end
end
