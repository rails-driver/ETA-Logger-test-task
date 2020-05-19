class EtaLogger
  class_attribute :redis, default: REDIS_CLIENT

  def self.agent_redis_key(agent_id)
    "eta_logger::#{agent_id}"
  end

  def record(agent_id:, msg:)
    key = EtaLogger.agent_redis_key(agent_id)
    log_entry = { msg: msg, created_at: DateTime.now }
    redis.multi do |multi|
      multi.rpush(key, Marshal.dump(log_entry))
      multi.expire(key, 7.days.seconds)
    end
    log_entry
  end
end
