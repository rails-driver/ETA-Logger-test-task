module ServiceHelpers
  def redis_client
    REDIS_CLIENT
  end
end

RSpec.configure do |config|
  config.include ServiceHelpers
end
