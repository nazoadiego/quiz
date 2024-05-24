class QuestionTemplate
  ONE_CORRECT_ANSWER = {
    type: :one_correct_answer,
    scorable: nil,
    max_score: nil,
    answer_score: nil,
    options: [],
    answer: nil,
    correct_answer: nil
  }


  MULTIPLE_CORRECT_ANSWERS = {
    type: :multiple_correct_answers,
    scorable: nil,
    max_score: nil,
    answer_score: nil,
    options: [],
    answer: nil, 
    correct_answers: []
  }

  REDACTION = {
    type: :redaction,
    scorable: nil,
    max_score: nil,
    answer_score: nil,
    answer: nil
  }

  ALL_TYPES = [
    ONE_CORRECT_ANSWER, 
    MULTIPLE_CORRECT_ANSWERS, 
    REDACTION
  ]
end