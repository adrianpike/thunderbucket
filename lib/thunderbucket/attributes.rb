module Thunderbucket
	module Attributes
		def self.included(base); base.extend(ClassMethods); end
	
		module ClassMethods
			
			def attributes(*attrs)
				attrs.each {|attribute|
					add_attribute! attribute
					}
			end

			def add_attribute!(attribute)
				Thunderbucket.log("Adding attribute `#{attribute}` to #{self.class}")
				add_attribute_methods(attribute)
			end

			def add_attribute_methods(attribute)
				getter_code = <<-EOV
					def #{attribute}; @attribute_values[:#{attribute}]; end
				EOV

				setter_code = <<-EOV
					def #{attribute}=(val); @attribute_values[:#{attribute}] = val; end
				EOV
				
				class_eval(getter_code)
				class_eval(setter_code)
			end

		end
		
	end
end