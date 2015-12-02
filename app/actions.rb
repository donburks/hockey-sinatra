# Homepage (Root path)
get '/' do
  erb :index
end

get '/players' do
	Player.all.to_json
end

post '/new_player' do
	results = {result: false}
	name = params[:name]
	position = params[:position]
	weight = params[:weight]

	player = Player.new name: name, position: position, weight: weight

	if player.save
		results[:result] = true
		results[:player_id] = player.id
	end

	results.to_json	
end
