require 'sunspot/mongoid'
require 'rails'

module Sunspot::Mongoid
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.expand_path("../../../../tasks/sunspot_mongoid.rake", __FILE__)
    end
  end
end