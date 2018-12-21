require 'csv'

@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from a file"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
      get_student_count
    when "4"
      load_students(get_filename)
      get_student_count
    when "9"
       exit
    else
      puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the name of the student"
  puts "If there are no more students, hit return"
  name = STDIN.gets.chomp.capitalize
  while !name.empty? do
    insert_students_into_array(name, get_students_cohort, get_birth_country, get_hobby)
    puts "Now we have #{@students.count} students"
    puts "Please enter name of student or hit return if there are no more"
    name = STDIN.gets.chomp.capitalize
  end
end

def show_students
  print_header
  print_students_by_cohort(available_cohorts)
  print_footer
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print_students_by_cohort(cohorts)
  cohorts.each do |month|
    puts "Students in the #{month} cohort are as follows:".center(50)
    student_count = 0
    @students.each do |student|
      if student[:cohort] == month
       student_count += 1
       puts ""
       puts "#{student_count}. #{student[:name]} (#{student[:cohort]} cohort)".center(50)
       puts "#{student[:name]} was born in #{student[:birth_country]} and enjoys #{student[:hobby]} in their spare time"
       puts ""
      end  
    end
  end
end

def available_cohorts
  cohorts = []
  @students.each do |student|
    if !cohorts.include? student[:cohort]
      cohorts.push(student[:cohort])
    end
  end
  cohorts
end

def print_footer
  puts ""
  if @students.count > 1
    puts "Overall, we have #{@students.count} great students".center(50)
  else
    puts "Overall, we have #{@students.count} great student".center(50)
  end
end

def save_students
  CSV.open(get_filename, "a") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort], student[:birth_country], student[:hobby]]
    end
  end
end

def get_filename
  puts "Please enter the name of the file"
  filename = gets.chomp
  while !File.exists?(filename)
    puts "Sorry '#{filename}' doesn't exit, please try again"
    filename = gets.chomp
  end
  filename
end

def get_student_count
  puts "There are now #{@students.count} students"
end

def load_students(filename = "students.csv")
  CSV.foreach(filename) do |row|
    name, cohort, birth_country, hobby = row
    insert_students_into_array(name, cohort, birth_country, hobby)
  end  
end

def insert_students_into_array(name, cohort, birth_country, hobby)
  @students << {name: name, cohort: cohort, birth_country: birth_country, hobby: hobby}
end

def get_students_cohort
  cohorts = [:November, :January, :March, :May, :July, :September]
  puts "Which cohort is this student part of? If you're not sure, hit return"
  cohort = STDIN.gets.chomp.capitalize.to_sym
  if cohort.empty?
    cohort = :November
  else
    while !cohorts.include?(cohort) do
      puts "That isn't an available cohort, please try again"
      cohort = gets.chomp.capitalize.to_sym
    end
  end
  cohort
end

def get_hobby
  puts "What is their hobby?"
  hobby = STDIN.gets.chomp
end

def get_birth_country
  puts "Where are they from?"
  birth_country = STDIN.gets.chomp
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    load_students
    puts "Loaded #{@students.count} from students.csv"
  elsif File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu
