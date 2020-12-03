# The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.

struct Entry
  getter first : Int32, second : Int32, password : String, letter : Char

  def initialize(entry)
    matches = /(\d+)-(\d+) (.):(.*)/.match(entry).not_nil!
    
    @first = matches[1].to_i
    @second = matches[2].to_i
    @letter = matches[3][0]
    @password = matches[4]
  end
end

def valid_password_sled_rental(entry)
  appearances = entry.password.count(entry.letter)
  appearances >= entry.first && appearances <= entry.second
end

def valid_password_toboggan(entry)
  (entry.password[entry.first] == entry.letter) ^ (entry.password[entry.second] == entry.letter)
end

def solve_2_1(passwords)
  passwords.map { |str| Entry.new(str) }.select { |entry| valid_password_sled_rental entry }.size
end

def solve_2_2(passwords)
  passwords.map{ |str| Entry.new(str) }.select { |entry| valid_password_toboggan entry }.size
end
