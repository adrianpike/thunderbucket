require 'helper'

class Example < Thunderbucket::Base
	
end

class TestThunderbucket < Test::Unit::TestCase
  should "be able to specify basic thunderbucket models" do
		
		@ex = Example.new
		@ex.foobar = 'lol'
		@ex.save
	
  end
end
