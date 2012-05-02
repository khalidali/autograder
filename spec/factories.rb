
baseTime = Time.now

Factory.define :assignment do |a|
    a.due_date baseTime
    a.inst_key 'prof_key'
end


Factory.define :student do |s|
    s.key  'key'
    s.assignment_id '1'
    s.created_at baseTime
    s.updated_at baseTime
end

Factory.define :submission do |su|
    su.body 'submission1'
    su.output 'great'
    su.status 'pending'
    su.student_id '1'
    su.created_at baseTime
    su.updated_at baseTime
end
