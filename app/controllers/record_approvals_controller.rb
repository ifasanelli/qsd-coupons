class RecordApprovalsController < ApplicationController
  def index
    @record_approvals = RecordApproval.all
  end
end
