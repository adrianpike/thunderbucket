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
			backend = Thunderbucket.backend
			Thunderbucket.log("Saving to a #{backend}")
			backend.set(self.id, backend.serialize_attributes(@attribute_values))
		end
		
		def self.free_backend
		end
		
		def self.initialize_backend(backend)
			Thunderbucket.log("Initializing a backend of #{backend}")
			Memory.new
		end

		class Store
			
			def serialize_attributes(attributes)
				Thunderbucket.log("Serializing #{attributes}")
				attributes.to_yaml
			end
			
			def deserialize_attributes(data)
				Thunderbucket.log("Deserializing #{data}")
				YAML.load(data)
			end
			
			def set(key,val)
			end
			
			def get(key)
			end
			
			def transact(&block)
			end
			
			def next_id_for(object)
			end
			
		end
	
	end
end