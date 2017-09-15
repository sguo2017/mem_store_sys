class Admin::Report::FlowAnalysesController < AdminController
    before_action :forbid_super_admin
  def index
  end
end
