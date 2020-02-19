class RemoveDateFromRecordApprovals < ActiveRecord::Migration[6.0]
  def change

    remove_column :record_approvals, :date, :datetime
  end
end
