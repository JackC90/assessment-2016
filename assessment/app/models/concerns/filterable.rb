module Filterable
	extend ActiveSupport::Concern

	module ClassMethods
		def filter(filtering_params)
			results = Product.where(nil)
			filtering_params.each do |key, value|
				results = results.send(key, value) if value.present?	
			end
			results
		end
	end 
end