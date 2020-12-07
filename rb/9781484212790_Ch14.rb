require 'net/http'

Net::HTTP.start("www.apress.com", use_ssl: true) do |http|
  req = Net::HTTP::Get.new('/sitemap.xml')
  body = http.request(req).body
  puts body.force_encoding("UTF-8")
end

# ----

require 'net/http'

url = URI.parse('https://www.apress.com/sitemap.xml')

Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
  req = Net::HTTP::Get.new(url.path)
  body = http.request(req).body
  puts body.force_encoding("UTF-8")
end

# ----

require 'net/http'

url = URI.parse('https://www.apress.com/sitemap.xml')
response = Net::HTTP.get_response(url)
puts response.body.force_encoding("UTF-8")

# ----

require 'net/http'

def get_web_document(url)
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)

  case response
  when Net::HTTPSuccess
    return response.body.force_encoding("UTF-8")
  when Net::HTTPRedirection
    return get_web_document(response['Location'])
  else
    return nil
  end
end

puts get_web_document('https://www.apress.com/sitemap.xml')
puts get_web_document('https://www.apress.com/doesnotexist.xml')
puts get_web_document('https://ruby-doc.org/core')

# ----

require 'net/http'

url = URI.parse('http://browserspy.dk/password-ok.php')

Net::HTTP.start(url.host, url.port) do |http|
  req = Net::HTTP::Get.new(url.path)
  req.basic_auth('test', 'test')
  puts http.request(req).body
end

# ----

require 'net/http'

url = URI.parse('fakeserver.apress.com/form.cgi')

response = Net::HTTP.post_form(url,{'name' => 'David', 'age' => '24'})
puts response.body

# ----

require 'net/http'

url = URI.parse('fakeserver.apress.com/form.cgi')

Net::HTTP.start(url.host, url.port) do |http|
  req = Net::HTTP::Post.new(url.path)
  req.set_form_data({ 'name' => 'David', 'age' => '24' })
  puts http.request(req).body
end

# ----

web_proxy = Net::HTTP::Proxy('your.proxy.hostname.or.ip', 8080)

# ----

require 'net/http'

web_proxy = Net::HTTP::Proxy('your.proxy.hostname.or.ip', 8080)

url = URI.parse('https://www.apress.com/sitemap.xml')

web_proxy.start(url.host, url.port, use_ssl: true) do |http|
  req = Net::HTTP::Get.new(url.path)
  puts http.request(req).body.force_encoding("UTF-8")
end

# ----

require 'net/http'

web_proxy = Net::HTTP::Proxy('your.proxy.hostname.or.ip', 8080)
url = URI.parse('https://www.apress.com/sitemap.xml')

response = web_proxy.get_response(url)
puts response.body.force_encoding("UTF-8")

# ----

require 'net/http'

http_class = ARGV.first ? Net::HTTP::Proxy(ARGV[0], ARGV[1]) : Net::HTTP
url = URI.parse('https://www.apress.com/sitemap.xml')

response = http_class.get_response(url)
puts response.body.force_encoding("UTF-8")
# ----

require 'net/http'

url = URI.parse('https://www.apress.com/sitemap.xml')

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true if url.scheme == 'https'

request = Net::HTTP::Get.new(url.path)
puts http.request(request).body.force_encoding("UTF-8")

# ----

require 'net/http'
# This isn't a working URL, replace with a URL that accepts POST request
url = URI.parse('https://your.serversomewhere.com/form1')

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true if url.scheme == 'https'

request = Net::HTTP::Post.new(url.path)
request.set_form_data({ 'credit_card_number' => '1234123412341234' })
puts http.request(request).body.force_encoding("UTF-8")

# ----

require 'open-uri'

f = open('https://www.apress.com/sitemap.xml')
puts f.readlines.join

# ----

require 'open-uri'

f = open('https://www.apress.com/sitemap.xml')

puts "The document is #{f.size} bytes in length"

f.each_line do |line|
  puts line
end
# ----

require 'open-uri'

open('https://www.apress.com/sitemap.xml') do |f|
  puts f.readlines.join
end

# ----

require 'open-uri'

url = URI.parse('https://www.apress.com/sitemap.xml')
url.open { |f| puts f.read }

# ----

require 'open-uri'
puts URI.parse('https://www.apress.com/sitemap.xml').open.read

# ----

require 'open-uri'

f = URI.open('https://www.apress.com/sitemap.xml')

puts f.content_type
puts f.last_modified

# ----

require 'open-uri'

f = URI.open('https://www.apress.com/sitemap.xml',
  { 'User-Agent' => 'Mozilla/5.0 (platform; rv:geckoversion) Gecko/geckotrail Firefox/firefoxversion'})
puts f.read

# ----

require 'nokogiri'

html = <<END_OF_HTML
<html>
<head>
<title>This is the page title</title>
</head>
<body>
<h1>Big heading!</h1>
<p>A paragraph of text.</p>
<ul><li>Item 1 in a list</li><li>Item 2</li><li class="highlighted">Item
3</li></ul>
</body>
</html>
END_OF_HTML

doc = Nokogiri::HTML(html)
puts doc.css("h1").first.inner_html

# ----

require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(URI.open('https://www.apress.com/us/about'))
puts doc.css("h1").first.inner_html

# ----

list = doc.css("ul").first
list.css("li").each do |item|
  puts item.inner_html
end

# ----

list = doc.at("ul")

# ----

list = doc.at("ul")
highlighted_item = list.at(".search")
puts highlighted_item.inner_html

# ----

# [
#   {
#     "name": "Peter Cooper",
#     "gender": "Male"
#   },
#   {
#     "name": "Carleton DiLeo"
#     "gender": "Male"
#   }
# ]

# ----

require 'json'

json = <<END_JSON
[
  {
    "name": "Peter Cooper",
    "gender": "Male"
  },
  {
    "name": "Carleton DiLeo",
    "gender": "Male"
  }
]
END_JSON

people = JSON.parse(json, symbolize_names: true)

people.each do |person|
  puts "#{person[:name]} is a #{person[:gender]}"
end

# ----

people = JSON.parse(json)
people.each do |person|
  puts "#{person['name']} is a #{person['gender']}"
end

# ----

require 'net/pop'

mail_server = Net::POP3.new('mail.mailservernamehere.com')

begin
  mail_server.start('username','password')
  if mail_server.mails.empty?
    puts "No mails"
  else
    puts "#{mail_server.mails.length} mails waiting"
  end
rescue
  puts "Mail error"
end

# ----

mail_server.mails.each do |m|
  mail = m.pop
  puts mail
end

# ----

mail_server.mails.each do |m|
  m.delete if m.pop =~ /\bthis is a spam e-mail\b/i
end

# ----

mail_server.mails.each do |m|
  m.delete if m.header =~ /Subject:.+?medicines\b/i
end

# ----

require 'net/smtp'

message = <<MESSAGE_END
From: Private Person <me@privacy.net>
To: Author of Beginning Ruby <test@rubyinside.com>
Subject: SMTP e-mail test

This is a test e-mail message.
MESSAGE_END

Net::SMTP.start('localhost') do |smtp|
  smtp.send_message message, 'me@privacy.net', 'test@rubyinside.com'
end

# ----

Net::SMTP.start('mail.your-domain.com')

# ----

Net::SMTP.start('mail.your-domain.com', 25, 'localhost', 'username', ➥
'password', :plain)

# ----

require 'open-uri'

output = File.new('MD5SUM.txt', 'wb')
URI.open('ftp://cdimage.debian.org/debian-cd/current/amd64/iso-cd/MD5SUMS')
do |f|
  output.print f.read
end
output.close

# ----

require 'net/ftp'
require 'uri'

uri = URI.parse('ftp://cdimage.debian.org/debian-cd/current')

Net::FTP.open(uri.host) do |ftp|
  ftp.login 'anonymous', 'me@privacy.net'
  ftp.passive = true
  ftp.list(uri.path) { |path| puts path }
end

# ----

require 'net/ftp'

ftp = Net::FTP.new('cdimage.debian.org')
ftp.passive = true
ftp.login
ftp.list('*') { |file| puts file }
ftp.close

# ----

ftp.login(username, password)

# ----

ftp.chdir('debian-cd')

# ----

ftp.chdir('/debian-cd/current')

# ----

ftp.mkdir('test')

# ----

ftp.rename(filename, new_name)
ftp.delete(filename)

# ----

require 'net/ftp'

ftp = Net::FTP.new('cdimage.debian.org')
ftp.passive = true
ftp.login
ftp.chdir('/debian-cd/current/amd64/iso-cd/')
ftp.getbinaryfile('MD5SUMS')
ftp.close

# ----

ftp.getbinaryfile('MD5SUMS', 'local-filename', 1024) do |blk|
  puts "A 100KB block of the file has been downloaded"
end

# ----

ftp.getbinaryfile('MD5SUMS', 'local-filename', 1024) do |blk|
  .. do something with blk here ..
end

# ----

require 'net/ftp'

ftp = Net::FTP.new('ftp.domain.com')
ftp.passive = true
ftp.login
ftp.chdir('/your/folder/name/here')
ftp.putbinaryfile('local_file')
ftp.close

# ----

require 'net/ftp'

ftp = Net::FTP.new('ftp.domain.com')
ftp.passive = true
ftp.login
ftp.chdir('/your/folder/name/here')

count = 0

ftp.putbinaryfile('local_file', 'local_file', 100000) do |block|
  count += 100000
  puts "#{count} bytes uploaded"
end

ftp.close

# ----

require 'net/ftp'
require 'tempfile'

tempfile = Tempfile.new('test')

my_data = "This is some text data I want to upload via FTP."
tempfile.puts my_data

ftp = Net::FTP.new('ftp.domain.com')
ftp.passive = true
ftp.login
ftp.chdir('/your/folder/name/here')

ftp.puttextfile(tempfile.path, 'my_data')
ftp.close
tempfile.close
# ----

