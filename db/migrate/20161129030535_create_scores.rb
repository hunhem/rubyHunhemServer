class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :score
			t.integer :user_id
			t.string :account
			#t.integer :rank

      t.timestamps
    end
  end
end
