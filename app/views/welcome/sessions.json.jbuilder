json.array!(@sessions) do |session|
  json.extract! session, :id

  json.title "Ensaio, local: #{session.address}"
  json.start session.start_at
  json.end session.finish_at
  json.color from_status_to_color(session.status)

  # json.url session_url(session, format: :html)
end
