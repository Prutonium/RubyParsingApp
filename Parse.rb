date_array = []
download_array = []
file='http_access_log1'
error = 0
ln = 0
no_success = 0
redirected = 0

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
	download_array.push(download)
	outcome =  matches[3]
	outcome_filtered = /(\d{1})/ . match(outcome)
	success_code = outcome_filtered[1]
	if success_code == "4"
		no_success = no_success + 1
	end
	if success_code == "3"
		redirected = redirected + 1
	end
	puts date
	puts day
	puts download
	puts outcome
	
  end
  #date_array.push(date)

puts ln


  
end



print "Total Requests Made: " 
puts ln
print "Total Errors in Reading Requests: " 
puts error
decimal_error = error.to_f/ln.to_f
percent_error = (decimal_error * 100.0) 

print "Decimal Error: " 
puts decimal_error
print "Percent Error~ " 
print '%.2f' % percent_error
puts"%"
puts" "

print "Requests not successful (any 4xx status code): "
puts no_success
print "Percent Requests not successful (any 4xx status code): "
decimal_percent_no_success = no_success.to_f/ln.to_f
percent_no_success = decimal_percent_no_success * 100.0
print '%.2f' % percent_no_success
puts"%"
print "Requests redirected elsewhere (any 3xx codes): "
puts redirected
print "Percent Requests not successful (any 3xx status code): "
decimal_percent_redirected = redirected.to_f/ln.to_f
percent_redirected = decimal_percent_redirected * 100.0
print '%.2f' % percent_redirected
puts"%"
