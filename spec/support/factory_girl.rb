require 'support/factory_girl'
# RSpec without Rails
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  FactoryGirl.definition_file_paths = [File.expand_path('../factories', __FILE__)]

end