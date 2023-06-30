class CreateApartments < ActiveRecord::Migration[6.1]
    def change
      create_table :apartments do |t|
        t.integer :number, null: false
  
        t.timestamps
      end
    end
  end