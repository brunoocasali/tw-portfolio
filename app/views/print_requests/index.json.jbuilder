json.array!(@print_requests) do |print_request|
  json.extract! print_request, :id
  json.url print_request_url(print_request, format: :json)
end
