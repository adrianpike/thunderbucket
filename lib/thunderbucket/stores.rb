module Thunderbucket
	module Stores
		autoload :Redis, 'thunderbucket/store_backends/redis'
		autoload :Memory, 'thunderbucket/store_backends/memory'
	
		def id
			@id ||= autoincrement_id
		end
		
		def autoincrement_id
			Thunderbucket.backend.next_id_for(self.class)
		end
	
		def save
			Thunderbucket.log("Saving to a #{backend}")
			Thunderbucket.backend.set(Thunderbucket.backend.namespace(self.class, self.id), backend.serialize_attributes(@attribute_values))
			self.class.indexed_attributes.each {|attrib|
				Thunderbucket.log("Updating index for #{attrib}")
				if @attribute_values[attrib] then 
					if @saved_attributes[attrib] and (@saved_attributes[attrib] != @attribute_values[attrib]) then
						Thunderbucket.backend.clear(Thunderbucket.backend.namespace(self.class, 'indexes', attrib, @saved_attributes[attrib]))
					else
						p @saved_attributes
						p @attribute_values
					end
					Thunderbucket.backend.set(Thunderbucket.backend.namespace(self.class, 'indexes', attrib, @attribute_values[attrib]), self.id)
				end
				
				@saved_attributes[attrib] = @attribute_values[attrib]
			}
		end
		
		def self.free_backend
		end
		
		def self.initialize_backend(backend)
			Thunderbucket.log("Initializing a backend of #{backend}")
			Memory.new # TODO
		end

		class Store
			
			def serialize_attributes(attributes)
				Thunderbucket.log("Serializing #{attributes}")
				attributes.to_yaml
			end
			
			def deserialize_attributes(data)
				YAML.load(data) unless data.nil?
			end
			
			def namespace(*tree)
				tree.join('.')
			end
			
			def denamespace(string)
				tree.split('.')
			end
			
			def set(key,val)
			end
			
			def get(key)
			end
			
			def clear(key)
			end
			
			def transact(&block)
			end
			
			def next_id_for(object)
			end
			
		end
	
	end
end