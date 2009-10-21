require 'helper'

class Person < Thunderbucket::Base
 	has_many :drinks
  belongs_to :school
	
	attributes :name, :city
	
	indexed_attributes :foobar
end

class Drink < Thunderbucket::Base
	belongs_to :person

	attributes :alcohol_content
end

class School < Thunderbucket::Base
	has_many :people

	attributes :location, :motto

	indexed_attributes :location
end

class TestThunderbucket < Test::Unit::TestCase
	context 'an unbacked store' do
		setup do
			Thunderbucket.backend = :memory
			# Thunderbucket.backend = [:redis, 'localhost']
		end
	
  	should "be able to set and get attributes" do
			@ex = Person.new
			str = random_string
			@ex.name = str
			assert_equal str, @ex.name
  	end

		should 'hit the store, autogen an id, and come back with the same datas' do
			@ex = Person.new
			str = random_string
			@ex.name = str
			@ex.save
			
			@bar = Person.find(@ex.id)
			assert_equal str, @bar.name
		end
		
		should 'have two objects with two different ids and different data without collisions' do
			str1 = random_string
			str2 = random_string
			
			@ex1 = Person.new
			@ex1.name = str1
			@ex1.save

			@ex2 = Person.new
			@ex2.name = str2
			@ex2.save
			
			@load1 = Person.find(@ex1.id)
			@load2 = Person.find(@ex2.id)
			
			assert_equal(str1, @ex1.name)
			assert_equal(str2, @ex2.name)
			assert_not_equal(@ex1.name, @ex2.name)
		end

		# incomplete

		should 'be able to search by indexed attributes' do
		end

		should 'have associations' do
		end

	end
end
