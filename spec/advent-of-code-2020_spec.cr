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
        ".#..#...#.#"
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
        ".#..#...#.#"
      ]).should eq(336)
    end
  end
end
