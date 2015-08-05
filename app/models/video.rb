class Video < ActiveRecord::Base
  belongs_to :category
  has_many :reviews, -> {order("Created_at DESC")}

  validates_presence_of :title, :description

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    where("title LIKE ?", "%#{search_term}%").order("created_at DESC")
    # whatever we pass in the part after the comma(,) replaces the question mark(?) and forms the SQL query
    # % before and after search_term are wildcard paramaters
  end

end