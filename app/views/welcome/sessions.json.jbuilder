json.array!(@sessions) do |session|
  json.extract! session, :id
  project = session.project

  json.title "Ensaio, cliente: #{project.owner.name}"
  json.start session.start_at
  json.end session.finish_at
  json.id session.id
  json.color from_status_to_color(session.status)
  json.description "<b>Data: </b>#{l(session.start_at, format: :short)}<br/>
                   <b>Projeto: </b>#{project.name}<br/>
                   <b>Cliente: </b>#{project.owner.name}<br/>
                   <b>Local: </b>#{session.address}"
end
