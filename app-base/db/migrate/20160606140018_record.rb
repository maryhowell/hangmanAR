class Record < ActiveRecord::Migration
  def change
    create_table :records do |x|
      x.integer :win, default: 0
      x.integer :loss, default: 0
      x.string :user_id
    end
  end
end
