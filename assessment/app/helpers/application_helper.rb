module ApplicationHelper
	def RM(number)
		number_to_currency(number, unit: "RM")
	end

	def format_date(date)
		date.strftime("%e %B %Y")
	end
end
