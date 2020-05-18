class EtaLogger
  class_attribute :redis, default: REDIS_CLIENT

  def self.agent_redis_key(agent_id)
    "eta_logger::#{agent_id}"
  end

  def record(agent_id:, msg:)
    key = EtaLogger.agent_redis_key(agent_id)
    redis.multi do |multi|
      multi.rpush(key, Marshal.dump(msg: msg, created_at: DateTime.now))
      multi.expire(key, 7.days.seconds)
    end
  end
end
