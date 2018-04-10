class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
              length: {minimum: 3}
  validates :text, presence: true,
              length: {minimum: 2}

   def self.search(params)
   articles = Article.where("text LIKE ? or title LIKE ?", "%#{params[:search]}%",
             "%#{params[:search]}%") if params[:search].present?
   articles # returns the articles containing the search words
 end
end
