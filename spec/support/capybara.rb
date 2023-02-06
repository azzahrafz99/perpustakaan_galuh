RSpec.configure do |config|
  config.before :each, js: true, type: :system do
    url = "http://#{ENV.fetch('SELENIUM_REMOTE_HOST', nil)}:4444/wd/hub"

    driven_by :selenium, using: :chrome, options: {
      browser: :remote,
      url: url,
      desired_capabilities: :chrome
    }

    Capybara.server_host = `/sbin/ip route|awk '/scope/ { print $9 }'`.strip
    Capybara.server_port = '43447'
    session_server       = Capybara.current_session.server
    Capybara.app_host    = "http://#{session_server.host}:#{session_server.port}"
  end
end
