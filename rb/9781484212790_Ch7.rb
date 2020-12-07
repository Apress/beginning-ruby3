puts "This is a test".vowels.join('-')

# ----

# place this into string_extensions.rb
class String
  def vowels
   self.scan(/[aeiou]/i)
  end
end

# ----

# this loads the aforementioned code in string_extensions.rb
require './string_extensions'
puts "This is a test".vowels.join('-')

# ----

# as does this
require_relative 'string_extensions'
puts "This is a test".vowels.join('-')

# ----

# and this
load 'string_extensions.rb'
puts "This is a test".vowels.join('-')

# ----

# place this into a.rb
puts "Hello from a.rb"

# ----

# this loads a.rb
require_relative 'a'
puts "Hello from b.rb"
require_relative 'a'
puts "Hello again from b.rb"

# ----

load 'a.rb'
puts "Hello from b.rb"
load 'a.rb'
puts "Hello again from b.rb"

# ----

$:.each { |d| puts d }

# ----

$:.push '/your/directory/here'
require 'yourfile'

# ----

$debug_mode = 0
require_relative $debug_mode == 0 ? "normal-classes" : "debug-classes"

# ----

%w{file1 file2 file3 file4 file5}.each { |l| require l }

# ----

require_relative 'b'

# ----

require_relative 'c'

# ----

def example
  puts "Hello!"
end

# ----

require_relative 'a'
example

# ----

class String
  def vowels
    self.scan(/[aeiou]/i)
  end
end

# ----

require 'string_extensions'
puts "This is a test".vowels.join('-')

# ----

require 'net/http'
uri = URI('https://ruby-doc.org')
http_request = Net::HTTP.new(uri.host, uri.port)
http_request.use_ssl = true
response = http_request.get('/')
puts response.body.force_encoding("ISO-8859-1")

# ----

require 'net/http'
url = URI.parse('https://ruby-doc.org/')
response = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
 http.get(url.path)
end
content = response.body

# ----

Person = Struct.new(:name, :age)
me = Person.new("Fred Bloggs", 25)
me.age += 1

# ----

require 'ostruct'
person = OpenStruct.new
person.name = "Fred Bloggs"
person.age = 25

# ----

# gem install chronic

# ----

# gem install -v 0.10.2 chronic

# ----

require 'chronic'
puts Chronic.parse('may 10th')

# ----

# gem update

# ----

# gem uninstall feedtools

# ----

# $ gem uninstall rubyforge

# ----

# source 'https://rubygems.org'
# gem 'nokogiri'
# gem 'rack', '~>1.5'

# ----

require 'bundler/setup'
require 'rack'
# Now Rack 1.5 or above is loaded properly and you can check by typing the
following:
Rack.version
Rack.release
# ----

