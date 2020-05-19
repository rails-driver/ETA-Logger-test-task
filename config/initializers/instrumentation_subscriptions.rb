# Subscribes on ActiveSupport notifications

ActiveSupport::Notifications.subscribe 'eta_logs.created' do |event|
  ActionCable.server.broadcast(
      "eta_logs_#{event.payload[:agent_id]}",
      log_partial: ApplicationController.render(partial: 'eta_logs/log', locals: { log: event.payload })
  )
end
