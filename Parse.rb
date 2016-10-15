date_array = []
file='http_access_log_cleanedup.txt'
error = 0
ln = 1

File.readlines(file).each do |line|
  ln += 1
  matches = /.* \[(.*) \-\d{4}\] "GET (.*?) HTTP\/1.0"\W(\d{3})/	.match(line)
  if matches == nil
	puts "Error line"
	error = error + 1
  else
	date = matches[1]
	day = date[0..10]
	date_array.push(day)
	download = matches[2]
	outcome =  matches[3]
	#puts date
	puts day
	puts download
	puts outcome
  end
  #date_array.push(date)

puts ln


  
end


#puts "Total Lines:" ln
#puts "Total Errors:" error
#percent_error = error/ln
#puts "Percent Error:" percent_error "%"
#while
