class InformationsImport
  include ActiveModel::Model
  require 'roo'

  attr_accessor :file

  def initialize(attributes={})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when ".csv" then Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def load_imported_users
    spreadsheet = open_spreadsheet
    data = Roo::Spreadsheet.open('lib/data.xlsx') 
    headers = data.row(1) 
    data.each_with_index do |row, idx|
      next if idx == 0 
      user_data = Hash[[headers, row].transpose]
      if User.exists?(firstname: user_data['FIRST_NAME'], lastname: user_data['LAST_NAME'], email: user_data['EMAIL_ID'])
        puts "User with email #{user_data['EMAIL_ID']} already exists"
        next
      end
      
      user = User.new(user_data)
      puts "Saving User with email '#{user.email}'"
      user.save!
  end

  def imported_users
    @imported_users ||= load_imported_users
  end

  def save
    if imported_users.map(&:valid?).all?
      imported_users.each(&:save!)
      true
    else
      imported_users.each_with_index do |user, index|
        user.errors.full_messages.each do |msg|
          errors.add :base, "Row #{index + 6}: #{msg}"
        end
      end
      false
    end
  end

end

