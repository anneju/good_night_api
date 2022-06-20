json.sleep_records @sleep_records do |sleep_record|
  json.id sleep_record.id
  json.duration sleep_record.duration
  json.created_at sleep_record.created_at

  json.user do
    user = sleep_record.user
    json.id user.id
    json.name user.name
  end
end
