class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :name
      t.integer :run_id
      t.string :url

      t.timestamps
    end
  end
end
