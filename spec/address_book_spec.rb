require_relative '../models/address_book.rb'

RSpec.describe AddressBook do

  let(:book) { AddressBook.new }  #applies it to all

# Create helper method to consolidate redundant code
  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eq expected_name
    expect(entry.phone_number).to eq expected_number
    expect(entry.email).to eq expected_email
  end

  describe "attributes" do
    it "should respond to entries" do
      expect(book).to respond_to(:entries)
    end

    it "should initialize entries as an array" do
      expect(book.entries).to be_a(Array)
    end

    it "should intialize entries as empty" do
      expect(book.entries.size).to eq(0)
    end
end

  describe "#remove_entry" do
    it "removes an entry using the name, phone number and email" do
      book.add_entry('Alberto Grau', '787.731.1958', 'alberto@gmail.com')
      name = 'Ada Lovelace'
      phone_number = '787.473.3402'
      email = 'augusta.king@lovelace.com'
      book.add_entry(name, phone_number, email)

      expect(book.entries.size).to eq(2)
      book.remove_entry(name, phone_number, email)
      expect(book.entries.last.name).to eq('Alberto Grau')
  end
end

  describe "#add_entry" do
    it "adds only one entry to the address book" do
      book.add_entry('Ada Lovelace', '787.473.3402', 'augusta.king@lovelace.com')

      expect(book.entries.size).to eq(1)
    end

    it "adds the correct information to entries" do
      book.add_entry('Bill', '787.473.3402', 'augusta.king@lovelace.com')
      new_entry = book.entries.first

      expect(new_entry.name).to eq('Bill')
      expect(new_entry.phone_number).to eq('787.473.3402')
      expect(new_entry.email).to eq('augusta.king@lovelace.com')
  end
end

# Test that AddressBook's .import_from_csv() method is working as expected
 describe "#import_from_csv" do
   it "imports the correct number of entries" do

     book.import_from_csv("entries.csv")
     book_size = book.entries.size

     #Check the size of the entries in AddressBook
     expect(book_size).to eql 5
   end

   it "imports the 1st entry" do
     book.import_from_csv("entries.csv")
     #Check the first Entry
     entry_one = book.entries[0]

     # helper method consolidated code
     check_entry(entry_one, "Bill", "555-555-4854", "bill@blocmail.com")
   end

   it "imports the 2nd entry" do
     book.import_from_csv("entries.csv")
     # Check the second entry
     entry_two = book.entries[1]

     check_entry(entry_two, "Bob", "555-555-5415", "bob@blocmail.com")
   end

   it "imports the 3rd entry" do
       book.import_from_csv("entries.csv")
       # Check the third entry
       entry_three = book.entries[2]

       check_entry(entry_three, "Joe", "555-555-3660","joe@blocmail.com")
     end

     it "imports the 4th entry" do
       book.import_from_csv("entries.csv")
       # Check the fourth entry
       entry_four = book.entries[3]

       check_entry(entry_four, "Sally", "555-555-4646", "sally@blocmail.com")
     end

     it "imports the 5th entry" do
     book.import_from_csv("entries.csv")
     # Check the fifth entry
     entry_five = book.entries[4]

     check_entry(entry_five, "Sussie", "555-555-2036", "sussie@blocmail.com")
   end
end
# ASSIGNMENT:Adding additional tests that will use data from a new csv
 describe "#import_from_new_csv" do
    it "imports the correct number of entries" do

     book.import_from_csv("entries_2.csv")
     book_size = book.entries.size

     #Check the size of the entries in AddressBook
     expect(book_size).to eq 3
   end

    it "imports the 1st entry" do
     book.import_from_csv("entries_2.csv")
     #Check the first Entry
     entry_one = book.entries[0]

     # helper method consolidated code
     check_entry(entry_one, "Adriana", "787-473-1999", "adri@gmail.com")
   end

   it "imports the 2nd entry" do
     book.import_from_csv("entries_2.csv")
     # Check the second entry
     entry_two = book.entries[1]

     check_entry(entry_two, "Alberto", "787-473-3402", "alberto@gmail.com")
   end

   it "imports the 3rd entry" do
       book.import_from_csv("entries_2.csv")
       # Check the third entry
       entry_three = book.entries[2]

       check_entry(entry_three, "Karen", "787-448-4033","kai@gmail.com")
     end
   end

   describe "#binary_search" do
    it "searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Dan")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Bill")
      expect(entry).to be_a Entry
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end


     it "searches AddressBook for Bob" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Bob")
       expect(entry).to be_a Entry
       check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
     end

     it "searches AddressBook for Joe" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Joe")
       expect(entry).to be_a Entry
       check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
     end

     it "searches AddressBook for Sally" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Sally")
       expect(entry).to be_a Entry
       check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
     end

     it "searches AddressBook for Sussie" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Sussie")
       expect(entry).to be_a Entry
       check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end

     it "searches AddressBook for Billy" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Billy")
       expect(entry).to be_nil
     end
  end

# ASSIGNMENT
  describe "#iterative_search" do
    it "searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Dan")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Bill")
      expect(entry).to be_a Entry
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end


     it "searches AddressBook for Bob" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Bob")
       expect(entry).to be_a Entry
       check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
     end

     it "searches AddressBook for Joe" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Joe")
       expect(entry).to be_a Entry
       check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
     end

     it "searches AddressBook for Sally" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Sally")
       expect(entry).to be_a Entry
       check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
     end

     it "searches AddressBook for Sussie" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Sussie")
       expect(entry).to be_a Entry
       check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end

     it "searches AddressBook for Billy" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Billy")
       expect(entry).to be_nil
     end
  end
end
