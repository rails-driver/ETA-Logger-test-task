describe EtaLogger do
  let(:logger) { EtaLogger.new }
  let(:agent_id) { 123 }
  let(:record_key) { 'eta_logger::123' }
  let(:msg) { 'Something to log' }

  describe '#record' do
    before do
      logger.record(agent_id: agent_id, msg: msg)
    end

    it 'creates a list with record' do
      expect(logged_records(record_key)).to match_array([
        include(
          msg: 'Something to log',
          created_at: be_within(2.seconds).of(DateTime.now)
        )
      ])
      expect(redis_client.ttl(record_key)).to be_within(2).of(7.days.seconds)
    end

    context 'called multiple time' do
      let(:msg2) { 'Something to log 2' }

      before do
        logger.record(agent_id: agent_id, msg: msg2)
      end

      it 'append a record in the list' do
        expect(logged_records(record_key)).to match_array([
          include(
            msg: 'Something to log',
            created_at: be_within(2.seconds).of(DateTime.now)
          ),
          include(
            msg: 'Something to log 2',
            created_at: be_within(2.seconds).of(DateTime.now)
          )
        ])
        expect(redis_client.ttl(record_key)).to be_within(2).of(7.days.seconds)
      end
    end
  end

  def logged_records(key)
    redis_client.lrange(key, 0, -1).map &Marshal.method(:load)
  end
end
