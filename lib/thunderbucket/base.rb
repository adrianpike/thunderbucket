module Thunderbucket
	class ThunderbucketException < Exception; end
	class NotFound < ThunderbucketException; end

	class Base

		def initialize
			@attribute_values = {}
			@saved_attributes = {}
		end

		def backend
			Thunderbucket.backend
		end
		
	end
	
	Base.class_eval do
		include Associations
		include Attributes
		include Finders
		include Indexes
		include Stores
	end
end