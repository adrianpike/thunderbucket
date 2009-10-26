require 'helper'


class TestThunderbucket < Test::Unit::TestCase
	context 'an unbacked and empty store' do
		setup do
			Thunderbucket.backend = :memory
			# Thunderbucket.clear_store!
			# Thunderbucket.backend = [:redis, 'localhost']
		end

		should 'have associations' do
			@p = Person.new
			@p.name = random_string
			@p.save
			
			@d = Drink.new
			@d.alcohol_content = random_string
			@d.person = @p
			@d.save
		
			@l_d = Drink.find(@d.id)
			@l_p = Person.find(@p.id)
			assert_not_nil @l_p.drinks
			assert_equal @l_p.drinks.first.id, @d.id
			assert_equal @l_d.person.id, @l_p.id
		end

	end
end