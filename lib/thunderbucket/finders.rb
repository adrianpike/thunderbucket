module Thunderbucket
	module Finders
		def self.included(base); base.extend(ClassMethods); end
		
		def load_from_id(id, limit=nil, sort=nil)
			attributes = backend.deserialize_attributes(backend.get(backend.namespace(self.class, id)))
			raise Thunderbucket::NotFound, "Id: #{id}" if attributes.nil?
			@attribute_values = attributes
			@saved_attributes = attributes.dup
			@id = id
		end

		module ClassMethods

			## Find an item
			# .find(id)
			# .find([:first,:last,:all(default)], {conditions as a hash}, :limit=>0..Infinity, :sort=>'attribute to sort by')
			def find(*args)
				if args.first.is_a? Hash then
					objs = []
					
					args.first.each {|attr,val|
							obj = self.new
							id = Thunderbucket.backend.get(Thunderbucket.backend.namespace(self.inspect,'indexes',attr,val))
							obj.load_from_id(id)
							objs <<	obj
						}
					
					objs
				elsif args.first.is_a? Integer or args.first.is_a? String then
					obj = self.new
					obj.load_from_id(args.first)
					obj
				end
				
			end

		end
	end
end