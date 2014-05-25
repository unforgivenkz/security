module UsersHelper

def login()
	base_login = request.env['REMOTE_USER'] #ENV['USERNAME']
	if base_login.nil?
		base_login = ENV['USER']
	end
	if request.env['REMOTE_USER'].nil? && ENV['USER'].nil?
		base_login = Resolv.getname(request.remote_ip)
	end
"#{base_login}"
end
end