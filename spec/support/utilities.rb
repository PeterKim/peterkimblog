include ApplicationHelper

RSpec::Matchers.define :have_error_message do |msg|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: msg)
  end
end

RSpec.configure do |config|
  config.include Requests::SessionHelpers
end
