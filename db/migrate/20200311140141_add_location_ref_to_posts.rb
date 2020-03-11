class AddLocationRefToPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :location, foreign_key: true
  end
end
