lines.each do |line|
  matches = /^(\S+).*GET\s(.*)\sHTTP\S*\s(\d+)/.match(line)
  time = matches[1]
  request = matches[2]
  status = matches[3]
do
