require "pars3k"

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

def parse!(parser, input)
  res = parser.parse(input)
  res.is_a?(ParseError) ? raise("Can't parse") : res
end
