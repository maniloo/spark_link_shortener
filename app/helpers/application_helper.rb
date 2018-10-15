module ApplicationHelper
	def link_protocol(link)
		link[0..7] == "https://" ? "https://" : "http://"
	end

	def link_body(link)
		link.gsub(link[0..7] == "https://" ? "https://" : link[0..6] == "http://" ? "http://" : "", "")
	end
end