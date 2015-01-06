module ApplicationHelper
	def full_title(page_title = '')
		base_title = "Tookiti"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

	def full_name(user)
		"#{user.first_name.capitalize} #{user.last_name.capitalize}"
	end

	def gravatar(user, options = {size: 240})
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: full_name(user), class: "gravatar")
	end
end
