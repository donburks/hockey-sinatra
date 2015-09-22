# Homepage (Root path)
get '/' do
	if session[:counter]
		session[:counter] += 1
	else
		session[:counter] = 0
	end
	if session[:user_id]
		@user = User.find(session[:user_id])
	end
  erb :index
end

get '/teams' do
	@teams = Team.all
	erb :'teams/teams'
end

get '/teams/:slug' do
	@team = Team.find_by(slug: params[:slug])
	erb :'teams/team'
end

get '/teams/:slug/players/new' do
	@team = Team.find_by(slug: params[:slug])
	erb :'players/new_player'
end

post '/players/create' do
	@team = Team.find(params[:id])

	if @team
		@team.players.create first_name: params[:first_name], last_name: params[:last_name], number: params[:number]
		redirect "/teams/#{@team.slug}"
	else
		redirect '/teams'
	end
end

post '/login' do
	email = params[:email]
	password = params[:password]

	user = User.find_by(email: email, password: password)

	if user
		session[:user_id] = user.id
	end

	redirect '/'
end

get '/logout' do
	session.clear
	redirect '/'
end
