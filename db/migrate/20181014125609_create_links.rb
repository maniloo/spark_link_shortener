class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :short,  null: false
      t.string :destination, null: false

      t.timestamps
    end

    add_index :links, :short, unique: true
  end
end
