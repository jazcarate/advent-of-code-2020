require "pars3k"
include Pars3k

require "../common"

alias Bag = String

def space
  Parse.char(' ')
end

def word
  Parse.join(Parse.many_of Parse.alphabet_lower)
end

def bag
  word.sequence { |adj|
    (space >> word << space << (Parse.string("bags") | Parse.string("bag")))
      .transform { |color| "#{adj} #{color}" }
  }
end

def numbered_bag
  Parse.int.sequence { |number|
    (space >> bag).transform { |name|
      {number.to_i, name}
    }
  }
end

def bags
  Parse.string("no other bags").transform { |_| [] of Tuple(Int32, String) } |
    Parse.delimited_list numbered_bag, Parse.string(", ")
end

def dep
  bag.sequence { |bag|
    (space >> Parse.string("contain") >> space >> bags).transform { |deps|
      {bag, deps}
    }
  } << Parse.char '.'
end

def find_outter_containers(deps_map, search)
  return [] of Bag if search.nil?
  search.reduce([] of Bag) { |acc, outter|
    acc + (find_outter_containers(deps_map, deps_map[outter]?)) << outter
  }
end

def find_inner_containers(containerd_map, search)
  return 0 if search.nil?
  search.reduce(1) { |acc, (n, inner)|
    acc + (n * find_inner_containers(containerd_map, containerd_map[inner]?))
  }
end

def solve_7_1(input)
  can_be_contained_in = Hash(Bag, Array(Bag)).new

  deps = input
    .map { |entry| parse!(dep, entry) }

  deps.each { |(outter, inners)|
    inners.each { |(_, inner)|
      can_be_contained_in[inner] = (can_be_contained_in[inner]? || [] of Bag) << outter
    }
  }
  innitial = "shiny gold"
  find_outter_containers(can_be_contained_in, can_be_contained_in[innitial]).to_set.size
end

def solve_7_2(input)
  contains = Hash(Bag, Array(Tuple(Int32, Bag))).new

  input
    .map { |entry| parse!(dep, entry) }
    .each { |inner, outters|
      contains[inner] = outters
    }

  innitial = "shiny gold"
  find_inner_containers(contains, contains[innitial]) - 1 # I'm counting the outter most bag once, so I -1
end
