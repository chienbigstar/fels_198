class Word < ApplicationRecord
  belongs_to :category
  
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :lessons, through: :results

  class << self
    def getListWord category_id, question_count
      where("category_id = #{category_id}").limit(question_count).ids
    end
  end
end
