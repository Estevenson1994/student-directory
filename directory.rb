def input_students
  puts "Please enter the name of the student"
  puts "If there are no more students, hit return"
  students = []
  default_value = :default
  cohorts = [:November, :January, :March, :May, :July, :September]
  name = gets.chomp.capitalize
  while !name.empty? do
    puts "Which cohort is this student part of? If you're not sure, just hit enter"
    cohort = gets.chomp.capitalize.to_sym
    if cohort.empty?
      cohort = default_value
    else
      while !cohorts.include?(cohort) do
        puts "That isn't an available cohort, please try again"
        cohort = gets.chomp.capitalize.to_sym
      end
    end
    puts "What is their country of birth?"
    birth_country = gets.chomp.capitalize
    puts "What is their favourite past time?"
    hobby = gets.chomp
    students << {name: name, cohort: cohort, birth_country: birth_country, hobby: hobby}
    puts "Now we have #{students.count} students"
    puts "Please enter name of student or hit return if there are no more"
    name = gets.chomp.capitalize
  end
  students
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print(students)
  cohorts = []
  students.each do |student|
    if !cohorts.include? student[:cohort]
      cohorts.push(student[:cohort])
    end
  end
  cohorts.each do |month|
    puts "Students in the #{month} cohort are as follows:".center(50)
    student_count = 0
    students.each_with_index do |student, index|
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
def print_footer(names)
  puts ""
  if names.count > 1
    puts "Overall, we have #{names.count} great students".center(50)
  else
    puts "Overall, we have #{names.count} great student".center(50)
end
end

students = input_students
print_header
print(students)
print_footer(students)
