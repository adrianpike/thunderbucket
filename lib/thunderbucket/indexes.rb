module Thunderbucket
	module Indexes
    def self.included(base); base.extend(ClassMethods); end
		
		module ClassMethods
			def indexed_attributes(*attrs)
			end
		end
		
	end
end