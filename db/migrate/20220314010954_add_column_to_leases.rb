class AddColumnToLeases < ActiveRecord::Migration[6.1]
    def change
      remove_column :leases, :rent, :decimal
      add_column :leases, :rent, :integer
    end
  end