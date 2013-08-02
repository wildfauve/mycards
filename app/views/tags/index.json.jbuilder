json.status "ok"
json.status_code 200
json.tags @tags do |json, t|
  if t.frequency > 0
    json.name t.token
    json.id t.id
  end
end