puts "Your program works!"

# ----

# ruby test.rb

# ----

#!/usr/bin/ruby

puts "Your program works!"

# ----

#!/usr/bin/env ruby

puts "Your program works!"

# ----

if RUBY_PLATFORM =~ /win32/
  puts "We're in Windows!"
elsif RUBY_PLATFORM =~ /linux/
  puts "We're in Linux!"
elsif RUBY_PLATFORM =~ /darwin/
  puts "We're in Mac OS X!"
elsif RUBY_PLATFORM =~ /freebsd/
  puts "We're in FreeBSD!"
else
  puts "We're running under an unknown operating system."
end

# ----

# irb(main):001:0> ENV.each {|e| puts e.join(': ') }

# ----

tmp_dir = '/tmp'
if ENV['OS'] =~ /Windows_NT/
  puts "This program is running under Windows NT/2000/XP!"
  tmp_dir = ENV['TMP']
elsif ENV['PATH'] =~ /\/usr/
  puts "This program has access to a UNIX-style file system!"
else
  puts "I cannot figure out what environment I'm running in!"
  exit
end

# [.. do something here ..]

# ----

p ARGV

# ----

# ruby argvtest.rb these are command line parameters

# ----

#!/usr/bin/env ruby
p ARGV

# ----

# ./argvtest.rb these are command line parameters

# ----

# cp /directory1/from_filename /directory2/destination_filename

# ----

#!/usr/bin/env ruby
from_filename = ARGV[0]
destination_filename = ARGV[1]

# ----

class String
  def vowels
    scan(/[aeiou]/i)
  end
end

# ----

"This is a test".vowels

# ----

require_relative 'string_extend'

# ----

Gem::Specification.new do |s|
  s.name = 'string_extend'
  s.version = '0.0.1'
  s.summary = "StringExtend adds useful features to the String class"
  s.platform = Gem::Platform::RUBY
  s.files = Dir.glob("**/**/**")
  s.test_files = Dir.glob("test/*_test.rb")
  s.authors = ["Your Name"]
  s.email = "your-email-address@email.com"
  s.required_ruby_version = '>= 2.0.0'
end

# ----

s.name = 'string_extend'

# ----

s.version = '0.0.1'

# ----

s.summary = "StringExtend adds useful features to the String class"

# ----

s.files = Dir.glob("**/**/**")

# ----

s.test_files = Dir.glob("test/*_test.rb")

# ----

s.required_ruby_version = '>= 2.0.0'

# ----

# gem build <spec file>

# ----

# gem build string_extend.gemspec

# ----

# bundle gem string_extend

# ----

# coding: utf-8

require_relative 'lib/string_extend/version'
Gem::Specification.new do |spec|
  spec.name = "string_extend"
  spec.version = StringExtend::VERSION
  spec.authors = ["Carleton DiLeo"]
  spec.email = ["example@email.com"]
  spec.summary = %q{TODO: Write a short summary, because RubyGems requires one.}
  spec.description = %q{TODO: Write a longer description or delete this line.}
  spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been
  added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    ` git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end

# ----

# gem install gem_name

# ----

# gem push your_gems_filename-0.0.1.gem

# ----

# rake release

# ----

#!/usr/bin/ruby

puts "Content-type: text/html\n\n"
puts "<html><body>This is a test</body></html>"

# ----

#!/usr/bin/ruby

require 'cgi'

cgi = CGI.new

puts cgi.header
puts "<html><body>This is a test</body></html>"

# ----

#!/usr/bin/ruby

require 'cgi'
cgi = CGI.new

text = cgi['text']

puts cgi.header
puts "<html><body>#{text.reverse}</body></html>"

# ----

#!/usr/bin/ruby

require 'cgi'
cgi = CGI.new

from = cgi['from'].to_i
to = cgi['to'].to_i

number = rand(to-from+1) + from

puts cgi.header
puts "<html><body>#{number}</body></html>"

# ----

# <form method="POST" action="http://www.example.com/test.cgi">
# For a number between <input type="text" name="from" value="" /> and
# <input type="text" name="to" value="" /> <input type="submit"
# value="Click here!" /></form>

# ----

require 'webrick'

server = WEBrick::GenericServer.new( :Port => 1234 )

trap("INT"){ server.shutdown }

server.start do |socket|
   socket.puts Time.now
end

# ----

require 'webrick'

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
     response.status = 200
     response.content_type = "text/plain"
     response.body = "Hello, world!"
  end
end

server = WEBrick::HTTPServer.new( :Port => 1234 )
server.mount "/", MyServlet
trap("INT"){ server.shutdown }
server.start

# ----

response.body = "You are trying to load #{request.path}"

# ----

require 'webrick'

class MyNormalClass
  def MyNormalClass.add(a, b)
    a.to_i + b.to_i
  end
  def MyNormalClass.subtract(a,b)
    a.to_i - b.to_i
  end
end

class MyServlet < WEBrick::HTTPServlet::AbstractServlet
  def do_GET(request, response)
    if request.query['a'] && request.query['b']
      a = request.query['a']
      b = request.query['b']
      response.status = 200
      response.content_type = 'text/plain'
      result = nil

      case request.path
        when '/add'
          result = MyNormalClass.add(a,b)
        when '/subtract'
          result = MyNormalClass.subtract(a,b)
        else
          result = "No such method"
      end

      response.body = result.to_s + "\n"
    else
      response.status = 400
      response.body = "You did not provide the correct parameters"
    end
  end
end

server = WEBrick::HTTPServer.new(:Port => 1234)
server.mount '/', MyServlet
trap('INT'){ server.shutdown }
server.start
