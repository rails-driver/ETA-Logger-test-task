Capybara.javascript_driver = :chrome
Capybara.default_driver = :chrome
Capybara.default_normalize_ws = true

Capybara.register_driver :chrome do |app|
  chrome_args = %w[
    --ignore-gpu-blacklist
    --disable-default-apps --disable-infobars --disable-notifications --disable-password-generation
    --disable-password-manager-reauthentication --disable-password-separated-signin-flow
    --disable-popup-blocking --disable-save-password-bubble --disable-translate --mute-audio
    --no-default-browser-check --window-size=1200,768 --no-sandbox --disable-setuid-sandbox --disable-gpu
    --disable-dev-shm-usage
  ]
  Capybara::Selenium::Driver.new(app,
    browser: :chrome,
    desired_capabilities: {
      idleTimeout: 300,
      commandTimeout: 500,
      loggingPrefs: {
        browser: 'ALL',
        performance: 'ALL'
      },
      chromeOptions: {
        w3c: false,
        args: chrome_args,
        perfLoggingPrefs: {
          enableNetwork: true,
          enablePage: false
        }
      }
    })
end
