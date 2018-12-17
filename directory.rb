@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
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
    when "4"
      load_students
    when "9"
       exit
    else
      puts "I don't know what you meant, try again"
  end
end


def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def input_students
  puts "Please enter the name of the student"
  puts "If there are no more students, hit return"
  name = STDIN.gets.chomp.capitalize
  while !name.empty? do
    cohort = get_cohort
    birth_country = get_birth_country
    hobby = get_hobby
    @students << {name: name, cohort: cohort, birth_country: birth_country, hobby: hobby}
    puts "Now we have #{@students.count} students"
    puts "Please enter name of student or hit return if there are no more"
    name = STDIN.gets.chomp.capitalize
  end
end

def get_cohort
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

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print_student_list
  cohorts = []
  @students.each do |student|
    if !cohorts.include? student[:cohort]
      cohorts.push(student[:cohort])
    end
  end
  cohorts.each do |month|
    puts "Students in the #{month} cohort are as follows:".center(50)
    student_count = 0
    @students.each_with_index do |student, index|
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

def print_footer
  puts ""
  if @students.count > 1
    puts "Overall, we have #{@students.count} great students".center(50)
  else
    puts "Overall, we have #{@students.count} great student".center(50)
end
end


 
def show_students
  print_header
  print_student_list
  print_footer
end
 
def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  puts "You have saved #{@students.count} student(s) to your selected file"
  file.close
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
