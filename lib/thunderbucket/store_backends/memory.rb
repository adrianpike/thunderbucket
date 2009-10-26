module Thunderbucket
	module Stores
	
		class Memory < Store
			
			def initialize
				@store = {} # LOL :D
				@ids = {}
			end
			
			def set(key, val)
				Thunderbucket.log("Setting #{key} to be #{val.to_s.tr("\n",'')}")
				@store[key] = val
			end
			
			def get(key)
				Thunderbucket.log("Getting #{key}")
				@store[key]
			end
			
			def clear(key)
				Thunderbucket.log("Clearing #{key}")
				@store[key] = nil
			end
			
			def next_id_for(model)
				if @ids[model] then
					@ids[model]+=1
				else
					@ids[model]=1
				end
			end
			
		end
		
	end
end