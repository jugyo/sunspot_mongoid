require 'sunspot/mongoid'
require 'rails'

module Sunspot::Mongoid
  class Railtie < Rails::Railtie
    railtie_name :sunspot_mongoid

    rake_tasks do
      load "tasks/sunspot_mongoid.rake"
    end
  end
end