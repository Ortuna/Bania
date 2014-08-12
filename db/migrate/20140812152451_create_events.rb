class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :calendar
      t.string :from
      t.string :body

      t.timestamps
    end
  end
end
