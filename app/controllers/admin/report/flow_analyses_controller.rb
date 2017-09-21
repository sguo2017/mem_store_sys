class Admin::Report::FlowAnalysesController < AdminController
    before_action :forbid_store_manager
  def index
  end
end
