describe 'ETALogger list' do
  let!(:first_agent_logs) do
    2.times.map do |index|
      create_log_entry(agent_id: 1001, msg: "Test 1001 #{index}")
    end
  end
  let!(:second_agent_logs) do
    2.times.map do |index|
      create_log_entry(agent_id: 1002, msg: "Test 1002 #{index}")
    end
  end

  before do
    visit '/'
  end

  context 'no search initiated' do
    it 'inform that user should enter search by agent ID' do
      content do
        assert_text 'Please enter agent ID in search form to see logs'
      end
    end
  end

  context 'search by existing agent ID' do
    before do
      fill_in 'agent_id', with: 1001
      click_button 'Search'
    end

    it 'see one agent log records' do
      content do
        within 'table' do
          assert_selector 'tbody tr', count: 2

          first_agent_logs.each do |log|
            within 'tr', text: log[:msg] do
              assert_text format_date(log[:created_at])
            end
          end
        end
      end
    end
  end

  context 'search by not existing agent ID' do
    before do
      fill_in 'agent_id', with: 99999
      click_button 'Search'
    end

    it 'see text that no records have been logged' do
      content do
        assert_text 'No records have been logged'
      end
    end
  end
end
