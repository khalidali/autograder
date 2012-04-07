
baseTime = Time.now

Factory.define :assignment do |a|
    a.due_date baseTime
    a.prof_key 'prof_key'
end
