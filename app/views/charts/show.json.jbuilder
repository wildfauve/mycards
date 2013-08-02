if @data['made_date'].present?
  json.timeline do |json|
#    json.time_interval 1.week * 1000
#    json.interval_start @data['made_date']['entries'].first['time']
    json.data @data['made_date']['entries'].collect {|a| [a['time'], a['count']]}
  end
end
