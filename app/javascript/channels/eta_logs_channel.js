import $ from 'jquery'
import consumer from './consumer'
import { urlParam } from '../helpers'

const agentId = urlParam('agent_id')

if (agentId) {
  consumer.subscriptions.create({ channel: 'EtaLogsChannel', agent_id: agentId }, {
    received (data) {
      const $table = $('#eta_logs_table')
      $table.find('.no-records-found').remove()
      $table.find('tbody').append(data.log_partial)
    }
  })
}
