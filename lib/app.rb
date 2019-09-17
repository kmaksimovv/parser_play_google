class App < Sequel::Model
  one_to_many :ratings
  
  def to_api
    {
      id: id,
      name: name,
      category: category,
      dowload_count: dowload_count,
      author: author,
      author_email: author_email,
      created_at: created_at
    }
  end
end
