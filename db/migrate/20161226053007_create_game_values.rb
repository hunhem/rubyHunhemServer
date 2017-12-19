class CreateGameValues < ActiveRecord::Migration
  def change
    create_table :game_values do |t|
			t.string :name

			t.float :objectGenerationTimeValue, default: 1.5
			t.float :objectSpeedValue,					default: 5.0

			t.float :playerSpeed,								default: 5.0
			t.float :playerMinSize,							default: 0.8
			t.float :playerShrinkVal,						default: 0.0357
			t.float :playerGrowVal,							default: 0.05
			t.float :playerContGrowVal,					default: 0.05
			t.float :sEneMinSize,								default: 0.5
			t.float :sEneMaxSize,								default: 1.5
			t.float :sEneSpawnFreq,							default: 8.5
			t.float :sEneSpeedMulti,						default: 1.5
			t.float :bEneMinSize,								default: 2.5
			t.float :bEneMaxSize,								default: 4.5
			t.float :bEneSpawnFreq,							default: 1.0
      t.float :bEneSpeedMulti,						default: 0.35
      t.float :triMinSize,								default: 0.5
      t.float :triMaxSize, 								default: 0.9
      t.float :triSpawnFreq, 							default: 0.25
      t.float :triSpeedMulti, 						default: 1.25

      t.timestamps
    end
  end
end
