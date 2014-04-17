class CreateValuetoprocesses < ActiveRecord::Migration
  def change
    create_table :valuetoprocesses do |t|
      t.text :value

      t.timestamps
    end
  end
end
