class EtaLogsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "eta_logs_#{params[:agent_id]}"
  end
end
