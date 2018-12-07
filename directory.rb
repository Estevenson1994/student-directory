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
      while cohorts.include?(cohort) == false do
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
  student_number = 0
  while student_number < students.length do
    puts ""
    puts "#{student_number + 1}. #{students[student_number][:name]} (#{students[student_number][:cohort]} cohort)".center(50)
    puts "#{students[student_number][:name]} was born in #{students[student_number][:birth_country]} and enjoys #{students[student_number][:hobby]} in their spare time"
    puts ""
    student_number += 1    
  end
end
def print_footer(names)
  puts ""
  puts "Overall, we have #{names.count} great students".center(50)
end

students = input_students
print_header
print(students)
print_footer(students)
