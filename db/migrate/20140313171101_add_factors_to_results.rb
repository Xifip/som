class AddFactorsToResults < ActiveRecord::Migration
  def change
    add_column :results, :factor_id, :integer
  end
end
