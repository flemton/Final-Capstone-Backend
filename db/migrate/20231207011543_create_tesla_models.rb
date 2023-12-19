class CreateTeslaModels < ActiveRecord::Migration[7.0]
  def change
    create_table :tesla_models do |t|
      t.string :name, null: false
      t.text :description
      t.integer :deposit, null: false
      t.integer :finance_fee, null: false
      t.integer :option_to_purchase_fee, null: false
      t.integer :total_amount_payable
      t.integer :duration
      t.boolean :removed

      t.timestamps
    end
  end
end
