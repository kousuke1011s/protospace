class CreatePrototypeTags < ActiveRecord::Migration
  def change
    create_table :prototype_tags do |t|
      t.references :tag, index: true, foreign_key: true
      t.references :prototype, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
