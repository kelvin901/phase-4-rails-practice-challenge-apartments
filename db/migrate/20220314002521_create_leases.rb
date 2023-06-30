class CreateLeases < ActiveRecord::Migration[6.1]
    def change
      create_table :leases do |t|
        t.decimal :rent, null: false
        t.belongs_to :apartment, null: false, foreign_key: true
        t.belongs_to :tenant, null: false, foreign_key: true
  
        t.timestamps
      end
    end
  end