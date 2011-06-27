require 'sunspot'
require 'mongoid'
require 'sunspot/rails'

# == Examples:
#
# class Post
#   include Mongoid::Document
#   field :title
# 
#   include Sunspot::Mongoid
#   searchable do
#     text :title
#   end
# end
#
module Sunspot
  module Mongoid
    def self.included(base)
      base.class_eval do
        extend Sunspot::Rails::Searchable::ActsAsMethods
        Sunspot::Adapters::DataAccessor.register(DataAccessor, base)
        Sunspot::Adapters::InstanceAdapter.register(InstanceAdapter, base)
      end
    end

    class InstanceAdapter < Sunspot::Adapters::InstanceAdapter
      def id
        @instance.id
      end
    end

    class DataAccessor < Sunspot::Adapters::DataAccessor
      def load(id)
		if @clazz.using_object_ids? then
			@clazz.find(BSON::ObjectID.from_string(id)) rescue nil
		else
			@clazz.find(id) rescue nil
		end
      end

      def load_all(ids)
		if @clazz.using_object_ids? then
			@clazz.where(:_id.in => ids.map { |id| BSON::ObjectId.from_string(id) })
		else
			@clazz.where(:_id.in => ids)
		end
      end
      
    end
  end
end
