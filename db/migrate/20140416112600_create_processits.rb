class CreateProcessits < ActiveRecord::Migration
  def change
    create_table :processits do |t|
      t.string :value

      t.timestamps
    end
  end
end
