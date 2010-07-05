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
        Sunspot::Adapters::DataAccessor.register(DataAccessor, base)
        Sunspot::Adapters::InstanceAdapter.register(InstanceAdapter, base)

        extend Sunspot::Rails::Searchable::ClassMethods
        include Sunspot::Rails::Searchable::InstanceMethods

        extend Sunspot::Mongoid::ClassMethods
      end
    end

    module ClassMethods
      def searchable(options = {}, &block)
        Sunspot.setup(self, &block)

        class_inheritable_hash :sunspot_options

        unless options[:auto_index] == false
          before_save :maybe_mark_for_auto_indexing
          after_save :maybe_auto_index
        end

        unless options[:auto_remove] == false
          after_destroy do |searchable|
            searchable.remove_from_index
          end
        end
        options[:include] = Sunspot::Util::Array(options[:include])

        self.sunspot_options = options
      end
    end

    class InstanceAdapter < Sunspot::Adapters::InstanceAdapter
      def id
        @instance.id
      end
    end

    class DataAccessor < Sunspot::Adapters::DataAccessor
      def load(id)
        @clazz.find(id) rescue nil
      end

      def load_all(ids)
        @clazz.criteria.in(:_id => ids)
      end
    end
  end
end
