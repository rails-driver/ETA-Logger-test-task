class EtaLogsSearch
  class_attribute :redis, default: REDIS_CLIENT

  def search(agent_id:)
    records = redis.lrange(EtaLogger.agent_redis_key(agent_id), 0, -1)

    return [] if records.nil?

    records.map &Marshal.method(:load)
  end
end
