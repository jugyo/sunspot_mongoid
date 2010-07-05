sunspot_mongoid
====

A Sunspot wrapper for Mongoid.

See also: [http://github.com/outoftime/sunspot/tree/master/sunspot_rails/](http://github.com/outoftime/sunspot/tree/master/sunspot_rails/)

Example
----

    require 'sunspot_mongoid'

    Mongoid.configure do |config|
      config.master = Mongo::Connection.new.db('sunspot-mongoid-test')
    end

    # model
    class Post
      include Mongoid::Document
      field :title

      include Sunspot::Mongoid
      sunspot_setup do
        text :title
      end
    end

    # indexing
    Post.create(:title => 'foo')
    Post.create(:title => 'foo bar')
    Post.create(:title => 'bar baz')

    # commit
    Sunspot.commit

    # search
    search = Post.search do
      keywords 'foo'
    end
    search.each_hit_with_result do |hit, post|
      p post
    end

    #=> #<Post _id: 4c319556327b3c4b42000001, title: "foo">
    #=> #<Post _id: 4c319556327b3c4b42000002, title: "foo bar">

Copyright
----

Copyright (c) 2010 jugyo. See LICENSE for details.
