class AddPaidToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :paid, :boolean, default: false
  end
end
