class CreateExamTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :exam_templates do |t|
      t.string :title
      t.jsonb :quiz_data, default: {}
      t.timestamp :version

      t.timestamps
    end
    add_index :exam_templates, :quiz_data, using: :gin
  end
end
