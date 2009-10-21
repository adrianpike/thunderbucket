module Thunderbucket
	module Associations
  	def self.included(base); base.extend(ClassMethods); end

		module ClassMethods
			
			def has_many(*whats)
			end
			
			def belongs_to(what)
			end
			
		end
	end
end