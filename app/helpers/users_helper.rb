module UsersHelper

def login()
	base_login = request.env['HTTP_REMOTE_USER']
	if base_login.nil?
		base_login = ENV['USER']
	end
	if ENV['USERNAME'].nil? && ENV['USER'].nil?
		base_login = request.remote_ip
	end
"#{base_login}"
end

end