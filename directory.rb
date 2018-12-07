def input_students
  puts "Please enter the name of the student"
  puts "If there are no more students, hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    puts "Which cohort is this student part of?"
    cohort = gets.chomp
    puts "What is their country of birth?"
    birth_country = gets.chomp
    puts "What is their favourite past time?"
    hobby = gets.chomp
    students << {name: name, cohort: cohort, birth_country: birth_country, hobby: hobby}
    puts "Now we have #{students.count} students"
    puts "Please enter name of student or hit return if you are done"
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
def print(students)
  student_number = 0
  while student_number < students.length do
    puts "#{student_number + 1}. #{students[student_number][:name]} (#{students[student_number][:cohort]} cohort)"
    puts "#{students[student_number][:name]} was born in #{students[student_number][:birth_country]} and enjoys #{students[student_number][:hobby]} in their spare time"
    student_number += 1    
  end
end
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
