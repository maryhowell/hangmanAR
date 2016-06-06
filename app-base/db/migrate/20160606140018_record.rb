class Record < ActiveRecord::Migration
  def change
    create_table :win_or_lose? do |x|
      x.integer :win, default: 0
      x.integer :loss, default: 0
      x.string :user_id
    end
  end
end
