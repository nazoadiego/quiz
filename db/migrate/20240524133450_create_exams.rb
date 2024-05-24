class CreateExams < ActiveRecord::Migration[7.1]
  def change
    create_table :exams do |t|
      t.references :teacher, null: false, foreign_key: { to_table: :users }
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :exam_template, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.timestamp :due_date
      t.jsonb :quiz_data, default: {}
      t.timestamp :version
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :exams, :quiz_data, using: :gin
  end
end
