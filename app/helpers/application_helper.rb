module ApplicationHelper

  def flash_class(level)
    case level.to_sym
      when :notice then "alert alert-success"
      when :info then "alert alert-info"
      when :alert then "alert alert-danger"
      when :warning then "alert alert-warning"
    end
  end

  def page_header(text)
    content_for(:page_header) { text.to_s }
  end

  def active_page(active_page)
    @active == active_page ? "active" : ""
  end

  def gravatar_for(email, size)
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    image_tag("http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}")
  end
end
