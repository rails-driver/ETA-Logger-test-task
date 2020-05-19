module FeatureHelpers
  def content(&block)
    within '.container', &block
  end

  def format_date(date)
    date.to_formatted_s(:short)
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end
