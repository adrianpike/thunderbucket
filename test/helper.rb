require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'thunderbucket'

class Test::Unit::TestCase
end


def random_string(length=10)
	value = ''; length.times { value << rand(93) + 33 }
	
	value
end