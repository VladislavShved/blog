class InitialModels < ActiveRecord::Migration[5.2]
  def change

    create_table :users do |t|
      t.string :login
    end

    create_table :posts do |t|
      t.string :header
      t.string :content
      t.string :author_ip

      t.integer :user_id
    end

    create_table :votes do |t|
      t.integer :mark

      t.integer :post_id
      t.integer :voter_id
    end

  end
end
