require "pars3k"
include Pars3k

def end_of_input
  Parser(Int32).new do |context|
    if context.position >= context.parsing.size
      ParseResult(Int32).new 0, context
    else
      ParseResult(Int32).error "expected end of input. Still have things to consume", context
    end
  end
end

def error(err)
  Parser(Int32).new do |context|
    ParseResult(Int32).error err, context
  end
end

def key_value(key, value_parser)
  Parse.string(key) << Parse.char(':') << value_parser
end

def any_of(parsers)
  parsers.reduce { |a, b| a | b }
end

def fields(fieldsP)
  spaces = Parse.one_or_more_of Parse.char ' '

  Parse.delimited_list(fieldsP, spaces) << end_of_input
end

def letter
  Parse.one_char_of "abcdefghijklmnopqrstuvwxyz"
end

def number
  Parse.one_char_of "01234567890"
end

def hex
  number | Parse.one_char_of "abcdef"
end

def any_value
  Parse.join (Parse.many_of letter | number | Parse.char '#')
end

def unchecked_fields
  fields(
    any_of(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]
      .map { |key| key_value(key, any_value) })
  )
end

# Not checking the 4 length criteria, because the numbers al already bound to 4 digic numbers
def bounded_int(from, to)
  Parse.int.transform(&.to_i).sequence { |number|
    if (number >= from) && (number <= to)
      Parse.constant number
    else
      error("Not the appropiate number")
    end
  }
end

def exactly(num, parser)
  Parse.some_of parser, num..num
end

def checked_fields
  fields(
    any_of([
      key_value("byr", bounded_int 1920, 2002),
      key_value("iyr", bounded_int 2010, 2020),
      key_value("eyr", bounded_int 2020, 2030),
      key_value("hgt", (bounded_int(59, 76) << Parse.string("in")) | (bounded_int(150, 193) << Parse.string("cm"))),
      key_value("hcl", Parse.char('#') >> exactly(6, hex)),
      key_value("ecl", any_of(
        ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].map { |key| Parse.string key }
      )),
      key_value("pid", exactly 9, number),
      key_value("cid", any_value),
    ])
  )
end

def span(arr, separator)
  arr.reduce([[] of String]) { |acc, line|
    if (line == separator)
      acc << [] of String
    else
      acc.last << line
    end
    acc
  }.map &.join(" ")
end

def contains_all?(fields)
  necesary = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  (necesary - fields).empty?
end

def check_passports(input, parser)
  passports = span(input, "")

  passports
    .map { |passport| parser.parse(passport) }
    .count { |fields|
      if fields.is_a?(Array(String))
        contains_all?(fields)
      else
        false
      end
    }
end

def solve_4_1(input)
  check_passports(input, unchecked_fields)
end

# TODO: This is bugged, it yeild too big of a number
def solve_4_2(input)
  check_passports(input, checked_fields)
end
