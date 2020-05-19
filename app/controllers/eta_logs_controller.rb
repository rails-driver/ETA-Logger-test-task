class EtaLogsController < ApplicationController
  def index
    @logs = EtaLogsSearch.new.search(agent_id: params[:agent_id]) if params[:agent_id]
  end
end
