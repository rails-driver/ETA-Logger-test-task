module Factories
  def create_log_entry(args)
    eta_logger.record(**args)
  end

  def eta_logger
    @eta_logger ||= EtaLogger.new
  end
end

RSpec.configure do |config|
  config.include Factories
end
