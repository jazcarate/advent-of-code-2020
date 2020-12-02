# find the two entries that sum to 2020
def twentyTwenty(pair)
  pair[0] + pair[1] == 2020
end

def twentyTwenty2(triple)
  triple[0][0] + triple[0][1] + triple[1] == 2020
end

def solve_1_1(report)
  p = report.product(report).select { |pair| twentyTwenty(pair) }.first
  p[0] * p[1]
end

def solve_1_2(report)
  p = report.product(report).product(report).select { |pair| twentyTwenty2(pair) }.first
  p[0][0] * p[0][1] * p[1]
end
