class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
			t.integer :rank
			t.integer :score_id		
			t.string :account
			t.integer :rank_score

      t.timestamps
    end
  end
end
