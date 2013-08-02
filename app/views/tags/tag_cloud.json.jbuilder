if @tag_cloud
  json.array!(@tag_cloud) do |json, tag|
    json.text tag[:token]
    json.weight tag[:freq]
    json.link url_for(searches_path(:search => tag[:token], :src => "tags"))
  end
end  