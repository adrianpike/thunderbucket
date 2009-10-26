require 'activesupport'

module Thunderbucket
	module Associations
  	def self.included(base); base.extend(ClassMethods); end

		module ClassMethods
			
			def has_many(*whats)
				whats.each {|what|
					my_class_name = what.to_s.singularize.humanize
				
					has_many_code = <<-EOV
						def #{what}
							#{my_class_name}.find(:all)
						end
					EOV
				
					class_eval(has_many_code)
				}
			end
			
			def belongs_to(*whats)
				whats.each {|what|
					
					belongs_to_code = <<-EOV
						def #{what}
							
						end
						
						def #{what}=(obj)
							
						end
					
					EOV
					
					class_eval(belongs_to_code)
				
				}
			end
			
		end
	end
end