class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :path
      t.string :title
      t.string :s3folder
      
      t.timestamps
    end
  end
end
