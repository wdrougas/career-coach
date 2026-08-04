class CreateAnalyses < ActiveRecord::Migration[8.1]
  def change
    create_table :analyses do |t|
      t.references :resume, null: false, foreign_key: true
      t.references :job, null: false, foreign_key: true
      t.integer :match_score
      t.text :summary

      t.timestamps
    end
  end
end
