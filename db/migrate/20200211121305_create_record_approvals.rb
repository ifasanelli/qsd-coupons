class CreateRecordApprovals < ActiveRecord::Migration[6.0]
  def change
    create_table :record_approvals do |t|
      t.string :email
      t.datetime :date
      t.references :promotion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
