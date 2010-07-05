$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'sunspot_mongoid'

Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db('sunspot-mongoid-test')
end

# model
class Post
  include Mongoid::Document
  field :title

  include Sunspot::Mongoid
  searchable do
    text :title
  end
end

# remove old indexes
Post.destroy_all

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
