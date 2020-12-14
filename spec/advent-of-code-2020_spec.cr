require "./spec_helper"

describe "Advent of code" do
  describe "1" do
    it "part 1" do
      report = [1721, 979, 366, 299, 675, 1456]
      solve_1_1(report).should eq(514579)
    end

    it "part 2" do
      report = [1721, 979, 366, 299, 675, 1456]
      solve_1_2(report).should eq(241861950)
    end
  end

  describe "2" do
    it "part 1" do
      valid_password_sled_rental(Entry.new("1-3 a: abcde")).should be_true
      valid_password_sled_rental(Entry.new("1-3 b: cdefg")).should be_false
      valid_password_sled_rental(Entry.new("2-9 c: ccccccccc")).should be_true

      solve_2_1(["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]).should eq(2)
    end

    it "part 2" do
      valid_password_toboggan(Entry.new("1-3 a: abcde")).should be_true
      valid_password_toboggan(Entry.new("1-3 b: cdefg")).should be_false
      valid_password_toboggan(Entry.new("2-9 c: ccccccccc")).should be_false

      solve_2_2(["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]).should eq(1)
    end
  end

  describe "3" do
    it "part 1" do
      solve_3_1([
        "..##.......",
        "#...#...#..",
        ".#....#..#.",
        "..#.#...#.#",
        ".#...##..#.",
        "..#.##.....",
        ".#.#.#....#",
        ".#........#",
        "#.##...#...",
        "#...##....#",
        ".#..#...#.#",
      ]).should eq(7)
    end

    it "part 2" do
      solve_3_2([
        "..##.......",
        "#...#...#..",
        ".#....#..#.",
        "..#.#...#.#",
        ".#...##..#.",
        "..#.##.....",
        ".#.#.#....#",
        ".#........#",
        "#.##...#...",
        "#...##....#",
        ".#..#...#.#",
      ]).should eq(336)
    end
  end

  describe "4" do
    it "part 1" do
      solve_4_1(["ecl:gry pid:860033327 eyr:2020 hcl:#fffffd",
                 "byr:1937 iyr:2017 cid:147 hgt:183cm",
                 "",
                 "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884",
                 "hcl:#cfa07d byr:1929",
                 "",
                 "hcl:#ae17e1 iyr:2013",
                 "eyr:2024",
                 "ecl:brn pid:760753108 byr:1931",
                 "hgt:179cm",
                 "",
                 "hcl:#cfa07d eyr:2025 pid:166559648",
                 "iyr:2011 ecl:brn hgt:59in"]).should eq(2)
    end

    it "part 2" do
      checked_fields.parse("eyr:1972 cid:100 hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926").should be_a(ParseError)
      checked_fields.parse("iyr:2019 hcl:#602927 eyr:1967 hgt:170cm ecl:grn pid:012533040 byr:1946").should be_a(ParseError)
      checked_fields.parse("hcl:dab227 iyr:2012 ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277").should be_a(ParseError)
      checked_fields.parse("hgt:59cm ecl:zzz eyr:2038 hcl:74454a iyr:2023 pid:3556412378 byr:2007").should be_a(ParseError)

      checked_fields.parse("pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980 hcl:#623a2f").should_not be_a(ParseError)
      checked_fields.parse("eyr:2029 ecl:blu cid:129 byr:1989 iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm").should_not be_a(ParseError)
      checked_fields.parse("hcl:#888785 hgt:164cm byr:2001 iyr:2015 cid:88 pid:545766238 ecl:hzl eyr:2022").should_not be_a(ParseError)
      checked_fields.parse("iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719").should_not be_a(ParseError)
    end
  end

  describe "5" do
    it "part 1" do
      seat_id(seat("BFFFBBFRRR")).should eq(567)
      seat_id(seat("FFFBBBFRRR")).should eq(119)
      seat_id(seat("BBFFBBFRLL")).should eq(820)
    end
  end

  describe "6" do
    it "part 1" do
      question_any?(["ab", "ac"]).should eq(3)
      question_any?(["a", "b", "c"]).should eq(3)
      question_any?(["abc"]).should eq(3)
      question_any?(["a", "a", "a"]).should eq(1)
    end

    it "part 2" do
      question_all?(["ab", "ac"]).should eq(1)
      question_all?(["a", "b", "c"]).should eq(0)
      question_all?(["abc"]).should eq(3)
      question_all?(["a", "a", "a"]).should eq(1)
    end
  end

  describe "7" do
    it "parser" do
      dep.parse("light red bags contain 1 bright white bag, 2 muted yellow bags.").should eq({"light red", [{1, "bright white"}, {2, "muted yellow"}]})
      dep.parse("dark orange bags contain 3 bright white bags, 4 muted yellow bags.").should eq({"dark orange", [{3, "bright white"}, {4, "muted yellow"}]})
      dep.parse("dotted black bags contain no other bags.").should eq({"dotted black", [] of Bag})
    end

    it "part 1" do
      input = ["light red bags contain 1 bright white bag, 2 muted yellow bags.",
               "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
               "bright white bags contain 1 shiny gold bag.",
               "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
               "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
               "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
               "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
               "faded blue bags contain no other bags.",
               "dotted black bags contain no other bags."]
      solve_7_1(input).should eq(4)
    end

    it "part 2" do
      input = [
        "shiny gold bags contain 2 dark red bags.",
        "dark red bags contain 2 dark orange bags.",
        "dark orange bags contain 2 dark yellow bags.",
        "dark yellow bags contain 2 dark green bags.",
        "dark green bags contain 2 dark blue bags.",
        "dark blue bags contain 2 dark violet bags.",
        "dark violet bags contain no other bags.",
      ]
      solve_7_2(input).should eq(126)
    end
  end

  describe "8" do
    it "parser" do
      instruction_line.parse("nop +0").should eq({"nop", 0})
      instruction_line.parse("acc +1").should eq({"acc", 1})
      instruction_line.parse("jmp -99").should eq({"jmp", -99})
    end

    it "part 1" do
      input = [
        "nop +0",
        "acc +1",
        "jmp +4",
        "acc +3",
        "jmp -3",
        "acc -99",
        "acc +1",
        "jmp -4",
        "acc +6",
      ]

      solve_8_1(input).should eq(5)
    end

    it "part 2" do
      input = [
        "nop +0",
        "acc +1",
        "jmp +4",
        "acc +3",
        "jmp -3",
        "acc -99",
        "acc +1",
        "jmp -4",
        "acc +6",
      ]

      solve_8_2(input).should eq(8)
    end
  end

  describe "9" do
    it "summing" do
      one_though_twenrty_five = (1..25).map { |i| i }
      is_sum?(26, one_though_twenrty_five).should eq(true)
      is_sum?(49, one_though_twenrty_five).should eq(true)
      is_sum?(100, one_though_twenrty_five).should eq(false)
      is_sum?(50, one_though_twenrty_five).should eq(false)
    end

    it "solve" do
      solve_9([35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576], 5).should eq({127, 9})
    end

    it "contiguos" do
      contiguos([35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576], 127).should eq([15, 25, 47, 40])
    end
  end

  describe "10" do
    it "part 1" do
      solve_10_1([16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]).should eq(7*5)
    end
  end

  describe "11" do
    it "part 1" do
      solve_11_1(["L.LL.LL.LL",
                  "LLLLLLL.LL",
                  "L.L.L..L..",
                  "LLLL.LL.LL",
                  "L.LL.LL.LL",
                  "L.LLLLL.LL",
                  "..L.L.....",
                  "LLLLLLLLLL",
                  "L.LLLLLL.L",
                  "L.LLLLL.LL"]).should eq(37)
    end

    it "part 2" do
      solve_11_2(["L.LL.LL.LL",
                  "LLLLLLL.LL",
                  "L.L.L..L..",
                  "LLLL.LL.LL",
                  "L.LL.LL.LL",
                  "L.LLLLL.LL",
                  "..L.L.....",
                  "LLLLLLLLLL",
                  "L.LLLLLL.L",
                  "L.LLLLL.LL"]).should eq(26)
    end
  end

  describe "12" do
    it "part 1" do
      solve_12_1(["F10",
                  "N3",
                  "F7",
                  "R90",
                  "F11"]).should eq(25)
    end

    it "part 1" do
      solve_12_2(["F10",
                  "N3",
                  "F7",
                  "R90",
                  "F11"]).should eq(286)
    end
  end

  describe "13" do
    it "part 1" do
      solve_13_1("939", "7,13,x,x,59,x,31,19").should eq(295)
    end
    it "part 2" do
      solve_13_2("7,13,x,x,59,x,31,19").should eq(1068781)
    end
  end
end
