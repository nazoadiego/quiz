class CreateEvaluations < ActiveRecord::Migration[7.1]
  def change
    create_table :evaluations do |t|
      t.references :exam, null: false, foreign_key: true
      t.integer :total_score, default: 0
      t.jsonb :quiz_data, default: {}
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :evaluations, :quiz_data, using: :gin
  end
end
