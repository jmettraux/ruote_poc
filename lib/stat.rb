
Dir["results/*.txt"].sort_by { |path|

  #path.split('_').last.to_i
  path

}.each do |path|

  next if path.match(/stat/)

  fname = File.basename(path)

  ss = fname.split("_")
  storage = ss[0]
  workers = ss[1]
  count = ss[3].to_i

  results = File.readlines(path)

  puts
  puts fname

  raise "failure! result count mismatch" if results.size != count

  times = results.collect { |l| l.split(' ').last.to_f }
  puts "min: #{times.min}"
  puts "max: #{times.max}"
  puts "avg: #{times.reduce(&:+) / count}"
end

