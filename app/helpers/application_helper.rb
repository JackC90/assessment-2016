module ApplicationHelper
	def RM(number)
		number_to_currency(number, unit: "RM") if number.present?
	end

	def format_date(date)
		date.strftime("%e %B %Y") if date.present?
	end

	def print_name(profile)
		if profile.class.name == "Profile"
			profile.name || profile.user.name || profile.user.username || "Visitor"
		else profile.class.name == "User"
			profile.profile.name || "Visitor"
		end
	end

	def yes_no(boolean)
		boolean ? "Yes" : "No"
	end
end

