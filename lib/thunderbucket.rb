require 'logger'

module Thunderbucket
	
	autoload :Base, 'thunderbucket/base'
	autoload :Associations, 'thunderbucket/associations'
	autoload :Stores, 'thunderbucket/stores'
	autoload :Attributes, 'thunderbucket/attributes'
	autoload :Finders, 'thunderbucket/finders'
	autoload :Indexes, 'thunderbucket/indexes'	
		
	def self.backend=(*backend)
		Thunderbucket.log("Setting backend to #{backend}")
		Stores.free_backend if @@store
		@@store=Stores.initialize_backend(backend)
	end
	
	def self.backend
		@@store
	end
	
	def self.initialize!
		@@logger = Logger.new(STDOUT)
		@@store = nil
	end
	
	def self.log(what, level=Logger::DEBUG)
		message_color = "4;33;1"
		log_entry = "  \e[#{message_color}m#{what}\e[0m   "
		@@logger.log(level,log_entry)
	end
	
end

Thunderbucket.class_eval do
	initialize!
end