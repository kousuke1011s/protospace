class AddLikeCountToPrototype < ActiveRecord::Migration
  def change
    add_column :prototypes, :like_count, :integer, default: 0, null: false
  end
end
