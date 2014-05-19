module UsersHelper

def login()
	base_login = ENV['USERNAME']
	if base_login.nil?
		base_login = ENV['USER']
	end
"#{base_login}"
end

end