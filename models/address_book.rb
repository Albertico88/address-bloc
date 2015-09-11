require_relative 'entry.rb'
require "csv"

class AddressBook
  attr_accessor :entries

  def initialize
    @entries = []
  end

  def nuke
    @entries = []
  end

  def remove_entry(name, phone_number, email)
    entry_to_delete = nil

    @entries.each do |entry|
      if name == entry.name && phone_number == entry.phone_number && email == entry.email
        entry_to_delete = entry
        break
      end
    end

    @entries.delete(entry_to_delete)
  end

  def add_entry(name, phone_number, email)
    index = 0
    @entries.each do |entry|
      if name < entry.name
        break
      end
      index += 1
    end
    # puts "Adding #{name}, #{phone_number}, #{email}"
    @entries.insert(index, Entry.new(name, phone_number, email))
  end

  def import_from_csv(file_name)
    csv_text = File.read(file_name) # Reads csv file
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    # The result of parse is an obj of type CSV::Table

    csv.each do |row|
      row_hash = row.to_hash
      # puts "Row to add: #{row_hash}"
      # Debug code-> puts "Phone: #{row_hash[:phone_number].inspect}"
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

    def import_from_new_csv(file_name)
      csv_text = File.read(file_name) # Reads csv file
      csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
      # The result of parse is an obj of type CSV::Table

      csv.each do |row|
        row_hash = row.to_hash
        add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
      end
    end

    def binary_search(name)
      lower = 0
   upper = entries.length - 1

# #2
   while lower <= upper
# #3
     mid = (lower + upper) / 2
     mid_name = entries[mid].name

# #4
     if name == mid_name
       return entries[mid]
     elsif name < mid_name
       upper = mid - 1
     elsif name > mid_name
       lower = mid + 1
     end
   end
      return nil
    end
end
