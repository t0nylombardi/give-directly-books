class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.boolean :available
      t.string :title
      t.string :timestamp, default: ""

      t.timestamps
    end

    add_index :books, :timestamp
  end
end
