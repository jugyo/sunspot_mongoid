module Sunspot
  module Rails
    class Railtie < ::Rails::Railtie
      initializer 'sunspot_rails.init' do
        Sunspot.session = Sunspot::Rails.build_session
        ActiveSupport.on_load(:mongoid) do
          include(Sunspot::Rails::RequestLifecycle)
        end
      end

      rake_tasks do
        load 'sunspot/rails/tasks.rb'
      end

      generators do
        load "generators/sunspot_rails.rb"
      end

    end
  end
end
