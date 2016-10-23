class Lesson < ApplicationRecord
  enum status: [:start, :testing, :finish]
  scope :desc, ->{order created_at: :desc}

  belongs_to :category
  belongs_to :user
  belongs_to :level

  has_many :results, dependent: :destroy
  has_many :words, through: :results

  accepts_nested_attributes_for :results,
    reject_if: proc {|attribute| attribute[:answer_id].blank?}

  def addResults wordId
    wordId.each do |i|
      self.results.create word_id: i
    end
  end

  def updateDeadline
    update_attributes deadline: Time.now + duration.to_i.minutes
  end

  def timeout?
    Time.zone.now > deadline
  end

  def updateScore
    score = results.select{|result| result.answer &&
      result.answer.is_correct?}.size
    update_attributes score: score
  end
end
