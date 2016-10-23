module LessonsHelper
  def getCategories
    @categories = Category.all.collect{|category| [category.name, category.id]}
  end

  def getDuration
    [
      [t("lesson.duration", duration: Settings.duration.length1),
        Settings.duration.length1],
      [t("lesson.duration", duration: Settings.duration.length2),
        Settings.duration.length2],
      [t("lesson.duration", duration: Settings.duration.length3),
        Settings.duration.length3]
    ]
  end

  def getQuestionCount
    [
      [t("lesson.question_counts", count: Settings.question_count.length1),
        Settings.question_count.length1],
      [t("lesson.question_counts", count: Settings.question_count.length2),
        Settings.question_count.length2],
      [t("lesson.question_counts", count: Settings.question_count.length3),
        Settings.question_count.length3]
    ]
  end

  def getLevel
    @levels = Level.all.collect{|level| [level.name, level.id]}
  end

  def itemCorrect? result, answer
    result.lesson.finish? && answer.is_correct? ? true : false
  end

  def itemIncorrect? result, answer
    result.lesson.finish? && 
      result.answer_id == answer.id && !answer.is_correct? ? true : false
  end

  def geTimeDuration lesson
    (lesson.deadline - Time.now).to_i
  end
end
