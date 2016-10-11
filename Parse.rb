file='http_access_log'
File.readlines(file).each do |line|
  puts line
end
