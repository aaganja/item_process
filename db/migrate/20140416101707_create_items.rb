class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :amount
      t.string :cost

      t.timestamps
    end
  end
end
