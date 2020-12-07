eval "puts 2 + 2"

# ----

puts eval("2 + 2")

# ----

my_number = 15
my_code = %{#{my_number} * 2}
puts eval(my_code)

# ----

def binding_elsewhere
  x = 20
  return binding
end

remote_binding = binding_elsewhere

x = 10
eval("puts x")
eval("puts x", remote_binding)

# ----

eval("x = 10")
eval("x = 50", remote_binding)
eval("puts x")
eval("puts x", remote_binding)

# ----

class Person
end

def add_accessor_to_person(accessor_name)
  Person.class_eval %{
    attr_accessor :#{accessor_name}
  }
end

person = Person.new
add_accessor_to_person :name
add_accessor_to_person :gender
person.name = "Carleton DiLeo"
person.gender = "male"
puts "#{person.name} is #{person.gender}"

# ----

Person.class_eval %{
  attr_accessor :#{accessor_name}
}

# ----

class Class
  def add_accessor(accessor_name)
    self.class_eval %{
      attr_accessor :#{accessor_name}
    }
  end
end

class Person
end

person = Person.new
Person.add_accessor :name
Person.add_accessor :gender
person.name = "Carleton DiLeo"
person.gender = "male"
puts "#{person.name} is #{person.gender}"

# ----

class SomethingElse
  add_accessor :whatever
end

# ----

class MyClass
  def initialize
    @my_variable = 'Hello, world!'
  end
end

obj = MyClass.new
obj.instance_eval { puts @my_variable }

# ----

class Person
  def name
    @name
  end

  def name=(name)
    @name = name
  end
end

# ----

class Person
  attr_accessor :name
end

# ----

class Class
  def add_accessor(accessor_name)
    self.class_eval %{
      def #{accessor_name}
        @#{accessor_name}
      end

      def #{accessor_name}=(value)
        @#{accessor_name} = value
      end
    }
  end
end

# ----

def name
  @name
end

def name=(value)
  @name = value
end

# ----

# OS X or Linux
x = system("ls")
x = `ls`

# ----

# Windows
x = system("dir")
x = `dir`

# ----

exec "ruby another_script.rb"
puts "This will never be displayed"

# ----

if fork.nil?
  exec "ruby some_other_file.rb"
end

puts "This Ruby script now runs alongside some_other_file.rb"

# ----

child = fork do
  sleep 3
  puts "Child says 'hi'!"
end

puts "Waiting for the child process..."
Process.wait child
puts "All done!"

# ----

ls = IO.popen("ls", "r")
while line = ls.gets
  puts line
end
ls.close

# ----

handle = IO.popen("other_program", "r+")
handle.puts "send input to other program"
handle.close_write
while line = handle.gets
  puts line
end

# ----

threads = []

10.times do
  thread = Thread.new do
    10.times { |i| print i; $stdout.flush; sleep rand(2) }
  end

  threads << thread
end

threads.each { |thread| thread.join }

# ----

threads.each do |thread|
  puts "Thread #{thread.object_id} didn't finish in 1s" unless thread.join(1)
end

# ----

10.times { Thread.new { 10.times { |i| print i; $stdout.flush; sleep rand(2) } } } Thread.list.each { |thread| thread.join unless thread == Thread.main }

# ----

Thread.new do
  10.times do |i|
    print i
    $stdout.flush
    Thread.stop
  end
end

# ----

Thread.list.each { |thread| thread.run }

# ----

2.times { Thread.new { 10.times { |i| print i; $stdout.flush; Thread.pass } } } Thread.list.each { |thread| thread.join unless thread == Thread.main }

# ----

sg = Fiber.new do
  s = 0
  loop do
    square = s * s
    Fiber.yield square
    s += 1
  end
end

10.times { puts sg.resume }

# ----

sg = Fiber.new do
  s = 0
  loop do
    square = s * s
    s += 1
    s = Fiber.yield(square) || s
  end
end

puts sg.resume
puts sg.resume
puts sg.resume
puts sg.resume
puts sg.resume 40
puts sg.resume
puts sg.resume
puts sg.resume 0
puts sg.resume
puts sg.resume

# ----

non_blocking = Fiber.new(blocking: false) do
  puts "Blocking Fiber? #{Fiber.current.blocking?}"
  # Will not block
  sleep 2
end
3.times { puts non_blocking.resume }

# ----

"this is a test".encoding

# ----

"ça va?".encoding

# ----

"ça va?".encode("ISO-8859-1")

# ----

"ça va?".encode("US-ASCII")

# ----

# coding: utf-8

# ----

