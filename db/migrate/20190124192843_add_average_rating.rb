class AddAverageRating < ActiveRecord::Migration[5.2]
  def change

    change_table :posts do |t|
      t.decimal :avg_vote, precision: 5, scale: 2, null: false, default: 0
      t.integer :marks_count, null: false, default: 0
    end

  end
end
