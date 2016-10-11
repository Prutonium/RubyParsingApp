file='http_access_log'
File.readlins(file).each do |line|
  puts line
end
