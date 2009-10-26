require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'thunderbucket'

class Test::Unit::TestCase
end

def random_string(length=10); value = ''; length.times { value << rand(93) + 33 }; value; end

class Person < Thunderbucket::Base
 	has_many :drinks
  belongs_to :school
	
	attributes :name, :city
	
	index_attributes :name
end

class Drink < Thunderbucket::Base
	belongs_to :person

	attributes :alcohol_content
end

class School < Thunderbucket::Base
	has_many :people

	attributes :location, :motto

	index_attributes :location
end
