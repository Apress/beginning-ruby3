10.times do print "Hello, world!" end

# ----

print "test"

# ----

print "2+3 is equal to " + 2 + 3

# ----

print "2+3 is equal to "
print 2 + 3

# ----

print "2+3 is equal to " + (2 + 3).to_s

# ----

class Person
  attr_accessor :name, :age, :gender
end

# ----

person_instance = Person.new

# ----

person_instance.name = "Christine"

# ----

person_instance.age = 52
person_instance.gender = "female"

# ----

puts person_instance.name

# ----

x = 10

# ----

x * 2

# ----

class Cat
  attr_accessor :name, :age, :gender, :color
end

class Dog
  attr_accessor :name, :age, :gender, :color
end

class Snake
  attr_accessor :name, :age, :gender, :color
end

# ----

class Pet
  attr_accessor :name, :age, :gender, :color
end

class Cat < Pet
end

class Dog < Pet
end

class Snake < Pet
end

# ----

class Snake < Pet
  attr_accessor :length
end

# ----

class Dog < Pet
  def bark
    puts "Woof!"
  end
end

# ----

a_dog = Dog.new
a_dog.bark

# ----

puts 1 + 10

# ----

puts a_dog.class

# ----

puts 2.class

# ----

puts "Hello, world!"

# ----

Kernel.puts "Hello, world!"

# ----

class Dog
  def bark
    puts “Woof!”
  end
end

# ----

my_dog = Dog.new
my_dog.bark

# ----

class Dog
  def bark(i)
    i.times do
      puts “Woof!”
    end
  end
end

# ----

my_dog = Dog.new
my_dog.bark(3)

# ----

class Dog
  def say(a, b, c)
    puts a
    puts b
    puts c
  end
end

# ----

my_dog = Dog.new
my_dog.say(“Dogs”, “can’t”, “talk!”)

# ----

puts “Hello”

# ----

puts(“Hello”)

# ----

puts "This is a test".length

# ----

puts "This is a test".upcase

# ----

def dog_barking
  puts "Woof!"
end

dog_barking

# ----

