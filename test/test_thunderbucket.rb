require 'helper'

class TestThunderbucket < Test::Unit::TestCase
	context 'an unbacked and empty store' do
		setup do
			Thunderbucket.backend = :memory
			# Thunderbucket.clear_store!
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

		should 'be able to change the same object again and again' do
			str = random_string
			str2 = random_string
			
			@ex = Person.new
			@ex.name = str
			@ex.save
			
			id = @ex.id
			
			@bar = Person.find(id)
			@bar.name = str2
			@bar.save
			
			@baz = Person.find(id)
			
			assert_equal(str2, @baz.name)
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
			
			assert_equal(str1, @load1.name)
			assert_equal(str2, @load2.name)
			assert_not_equal(@load1.name, @load2.name)
		end

		should 'be able to search by indexed attributes' do
			str1 = random_string
			@ex1 = Person.new
			@ex1.name = str1
			@ex1.save
			
			@load1 = Person.find(:name=>str1)
			assert_equal(str1, @load1.first.name)
		end
		
		should 'have unique namespaces and ids for two different classes' do
			str1 = random_string
			str2 = random_string
			
			@ex1 = Person.new
			@ex1.name = str1
			@ex1.save

			@ex2 = School.new
			@ex2.location = str2
			@ex2.save
			
			@load1 = Person.find(@ex1.id)
			@load2 = School.find(@ex2.id)
			
			assert_equal(str1, @load1.name)
			assert_equal(str2, @load2.location)
			assert_equal(@ex1.id,@ex2.id)
		end
		
		should 'clean up old indexes after a changed index value' do
			str1 = random_string
			str2 = random_string
			
			@ex1 = Person.new
			@ex1.name = str1
			@ex1.save
			
			@load1 = Person.find(:name=>str1)
			assert_equal(str1, @load1.first.name)
			
			@load1.first.name = str2
			@load1.first.save
			
			assert_raises Thunderbucket::NotFound do
				@load2 = Person.find(:name=>str1)
			end
			
			@load3 = Person.find(:name=>str2)
			assert_equal(str2, @load3.first.name)
		end

		should 'have created_at and updated_at' do
		end
		
		should 'have chained deletions' do
		end

		should 'pretty print an instance' do
		end

		should 'have sortable results' do
		end
		
		should 'have limitable results' do
		end
		
		should 'have validations' do
		end

	end
end
