require 'sunspot/rails'
Sunspot.session = Sunspot::Rails.build_session
ActionController::Base.module_eval { include(Sunspot::Rails::RequestLifecycle) }
