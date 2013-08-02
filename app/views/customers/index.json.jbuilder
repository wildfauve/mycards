json.status "ok"
json.status_code 200
json.customers @customers do |json, cust|
  json.name cust.name
  json.id cust.id
end