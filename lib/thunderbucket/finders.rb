module Thunderbucket
	module Finders
		def self.included(base); base.extend(ClassMethods); end
		
		module ClassMethods

			def find(*args)
				obj = self.new
				attributes = Thunderbucket.backend.deserialize_attributes(Thunderbucket.backend.get(args.first))
				attributes.each {|key,val| obj.send(key.to_s+'=', val) }
				
				obj
			end

		end
	end
end