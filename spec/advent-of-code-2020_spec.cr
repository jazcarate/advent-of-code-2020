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
end
