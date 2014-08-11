class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.text :content

      t.timestamps
    end
  end
end
