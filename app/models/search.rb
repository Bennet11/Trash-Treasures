class Search
  def self.for(keyword)
    keyword_search = "%#{keyword}%"

    Post.where('title LIKE ?', keyword_search)
  end
end
