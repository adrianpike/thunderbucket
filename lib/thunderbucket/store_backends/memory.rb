module Thunderbucket
	module Stores
	
		class Memory < Store
			
			def initialize
				@store = {} # LOL :D
				@ids = {}
			end
			
			def set(key,val)
				Thunderbucket.log("Setting #{key} to be #{val}")
				@store[key] = val
			end
			
			def get(key)
				@store[key]
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