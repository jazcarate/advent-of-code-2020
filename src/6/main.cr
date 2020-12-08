require "../common"

macro define_question_with(aggregation)
  def question_{{aggregation.id}}(answers)
    ('a'..'z').reduce(0) do |acc, i|
      if (answers.{{aggregation.id}} &.includes? i)
        acc + 1
      else
        acc
      end
    end
  end
end

define_question_with :any?
define_question_with :all?

def solve_6(input, f)
  groups = span(input, "")

  groups
    .map(&.split(/ /))
    .sum &f
end

def solve_6_1(input)
  solve_6 input, ->question_any?(Array(String))
end

def solve_6_2(input)
  solve_6 input, ->question_all?(Array(String))
end
