class AddS3folderToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :s3folder, :string
  end
end
