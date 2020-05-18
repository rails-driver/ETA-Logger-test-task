REDIS_CLIENT = Redis.new(url: Rails.env.test? ? ENV['TEST_REDIS_URL'] : ENV['REDIS_URL'])
