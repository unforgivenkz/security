module UsersHelper

def login()
	base_login = ENV['USERNAME']
	if base_login.nil?
		base_login = ENV['USER']
	end
	if ENV['USERNAME'].nil? && ENV['USER'].nil?
		base_login = "zero"
	end
"#{base_login}"
end

end