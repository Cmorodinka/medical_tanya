# coding: utf-8
# Load the rails application
require File.expand_path('../application', __FILE__)



# Initialize the rails application
Medical::Application.initialize!

require File.expand_path('../../lib/patches/abstract_mysql2_adapter.rb', __FILE__)

gem 'ts-delayed-delta', '1.1.2',
  :require => 'thinking_sphinx/deltas/delayed_delta'


