require 'helper'

#
# NOTE: I think tests are too few...
#
class TestSunspotMongoid < Test::Unit::TestCase
  class Foo
    include Mongoid::Document
    field :title

    include Sunspot::Mongoid
    sunspot_setup do
      text :title
    end
  end

  class Bar
    include Mongoid::Document
    field :title

    include Sunspot::Mongoid
    sunspot_setup(:auto_index => false, :auto_remove => false) do
      text :title
    end
  end

  context 'default' do
    should 'sunspot_options is specified' do
      assert Foo.sunspot_options == {:include => []}
      assert Bar.sunspot_options == {:auto_index=>false, :auto_remove=>false, :include=>[]}
    end

    should 'be called Sunspot.setup when call Foo.sunspot_setup' do
      mock(Sunspot).setup(Foo)
      Foo.sunspot_setup
    end

    should 'get as text_fields from Sunspot::Setup' do
      text_field = Sunspot::Setup.for(Foo).all_text_fields.first
      assert text_field.type == Sunspot::Type::TextType.instance
      assert text_field.name == :title
    end

    should 'search' do
      options = {}
      mock.proxy(Foo).solr_execute_search(options)
      mock(Sunspot).new_search(Foo) { mock(Object.new).execute }
      Foo.search(options)
    end
  end
end
