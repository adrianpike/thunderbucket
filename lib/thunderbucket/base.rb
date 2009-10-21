module Thunderbucket
	class Base

		class ThunderbucketException < Exception; end
		class NotFound < ThunderbucketException; end

		def initialize
			@attribute_values = {}
		end

		def self.initialize!
			@@attributes = []
		end
		
		def method_missing(method_id, *args, &block)
			Thunderbucket.log("Missing method #{method_id.to_s}")
		end
		
	end
	
	Base.class_eval do
		include Associations
		include Attributes
		include Finders
		include Indexes
		include Stores

		initialize!
	end
end