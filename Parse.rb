file='http_access_log'
File.readlines(file).each do |line|
  var1 = line.split[0]
  var2 = line.split[3]
  var3 = line.split[6]
  var4 = line.split[8]
  puts var1
  puts var2
  puts var3
  puts var4
end
