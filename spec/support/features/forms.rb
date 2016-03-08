module FeatureHelpers
  module Forms
    def submit_form(form_class)
      form = page.find("form.#{form_class}")
      class << form
        def submit!
          Capybara::RackTest::Form.new(driver, native).submit({})
        end
      end
      form.submit!
    end
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers::Forms, type: :feature
end
