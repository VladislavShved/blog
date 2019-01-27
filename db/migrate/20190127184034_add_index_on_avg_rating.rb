class AddIndexOnAvgRating < ActiveRecord::Migration[5.2]
  def change
    add_index :posts, :avg_vote
  end
end
