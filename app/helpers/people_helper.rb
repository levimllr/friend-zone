module PeopleHelper
  # Returns the Gravatar for the given person.
  def gravatar_for(person, options = { size: 80 })
    size = options[:size]
    gravatar_id = Digest::MD5::hexdigest(person.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: person.username, class: "gravatar")
  end
end
