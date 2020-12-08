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
