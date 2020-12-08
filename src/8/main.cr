require "bit_array"
require "pars3k"
include Pars3k

require "../common"

def instruction
  Parse.string("acc") | Parse.string("jmp") | Parse.string("nop")
end

def int
  Parse.int.transform &.to_i
end

def offset
  (Parse.char('+') >> int) | (Parse.char('-') >> int.transform { |n| -(n) })
end

def instruction_line
  instruction.sequence { |i|
    (Parse.char(' ') >> offset).transform { |n|
      {i, n}
    }
  }
end

def evaluate(input, pc, hits)
  acc = 0

  until pc >= input.size || hits[pc]
    hits.toggle(pc)
    op, offset = input[pc]

    case op
    when "acc"
      acc += offset
    when "jmp"
      pc += offset - 1
    end
    pc += 1
  end

  {hits, pc, acc}
end

def solve_8_1(input)
  instructions = input.map { |l| parse!(instruction_line, l) }
  _, _, acc = evaluate(instructions, 0, BitArray.new(input.size))
  acc
end

def can_change(line)
  op, _ = line
  op == "jmp" || op == "nop"
end

def change_op(original_op)
  case original_op
  when "nop" then "jmp"
  when "jmp" then "nop"
  else            original_op
  end
end

def change(instructions, i)
  new_instructions = instructions.dup
  op, off = new_instructions[i]

  new_instructions[i] = {change_op(op), off}
  new_instructions
end

def solve_8_2(input)
  size = input.size
  instructions = input.map { |l| parse!(instruction_line, l) }

  original_hits, original_pc, acc = evaluate(instructions, 0, BitArray.new(size))

  # (optimization) Only look for changes in instructions that where called, and that can be change
  _, op_to_change = original_hits
    .map_with_index { |hit, i| hit && can_change(instructions[i]) }
    .map_with_index { |hit, i| {hit, i} }
    .find { |care, i|
      next unless care # Skip things that we don't case

      new_instructions = change(instructions, i)
      new_mask = original_hits.dup
      new_mask.toggle(i)

      _, new_pc, _ = evaluate(
        new_instructions, # change the input
        i,                # Start with the changed location
        new_mask
      ) # if we hit some of the original loopingm then we can discard the attempt

      new_pc >= size
    } || raise "no things can be changed"

  good_instructions = change(instructions, op_to_change)

  _, _, acc = evaluate(good_instructions, 0, BitArray.new(size))
end
