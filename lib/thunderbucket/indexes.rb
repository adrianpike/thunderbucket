module Thunderbucket
	module Indexes
    def self.included(base); base.extend(ClassMethods); end

		module ClassMethods
			def index_attributes(*attrs)
				p "INDEXING #{attrs} in #{self.to_s}"
				@@indexed_attrs = [] unless defined?(@@indexed_attrs)
				@@indexed_attrs += attrs
			end
			
			def indexed_attributes
				@@indexed_attrs
			end
		end
		
	end
end