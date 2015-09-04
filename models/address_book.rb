require_relative 'entry'

class AddressBook
  attr_accessor :entries

def initialize
  @entries = []
end

def add_entry(name, phone_number, email)
  index = 0
  @entries.each do |entry|

    if name < entry.name    #what is this doing?
      break
    end
    index += 1
end

@entries.insert(index, Entry.new(name, phone_number, email))
end
end
