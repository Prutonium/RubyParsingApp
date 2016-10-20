require 'open-uri'
download_file = open('http://s3.amazonaws.com/tcmg412-fall2016/http_access_log')
#download_file = open('http://physis.arch.tamu.edu/files/http_access_log')
IO.copy_stream(download_file, 'my_file.file')
date_array = []
download_array = []
error = 0
ln = 0
no_success = 0
redirected = 0
File.readlines('my_file.file').each do |line|
  ln += 1
  matches = /.* \[(.*) \-\d{4}\] "GET (.*?) HTTP\/1.0"\W(\d{3})/	.match(line)
  if matches == nil
	#puts "Error line"
	error = error + 1
  else
	date = matches[1]
	day = date[0..10]
	month = date[3..5]+date[7..10]
	date_array.push(day)
	File.open("#{month}", 'a') do |f|
		f << line
	end
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
  end
end
puts " "
print "Total Requests Made: " 
puts ln
puts " "
puts "Requests Made Per Day: "
puts " "
puts date_array.inject(Hash.new(0)) { |total, e| total[e] += 1 ;total}
puts " "
#puts Hash[ date_array.group_by{|o|o}.map{|o,a|[o,a.length]}.sort_by{|o,ct|[-ct,o]} ]
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
print "Percent Requests redirected elsewhere (any 3xx status code): "
decimal_percent_redirected = redirected.to_f/ln.to_f
percent_redirected = decimal_percent_redirected * 100.0
print '%.2f' % percent_redirected
puts"%"
puts" "
download_array_organized = Hash[ download_array.group_by{|o|o}.map{|o,a|[o,a.length]}.sort_by{|o,ct|[-ct,o]} ]
print "Most Downloaded File: "
print download_array_organized.first 
puts " times"
download_array_organized_smallest = Hash[ download_array.group_by{|o|o}.map{|o,a|[o,a.length]}.sort_by{|ct,o|[o,-ct]} ]
print "Least Downloaded File: "
print download_array_organized_smallest.first 
puts " times"
