helpers do
	def current_user
		@user = User.find(session[:user_id]) if session[:user_id]
	end

	def get_error
		if session[:error]
			@error = session[:error]
			session[:error] = nil
		end
	end
end

before do
	current_user
	get_error
end

# Homepage (Root path)
get '/' do
	if session[:counter]
		session[:counter] += 1
	else
		session[:counter] = 0
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
	if @user.admin
		@team = Team.find_by(slug: params[:slug])
		erb :'players/new_player'
	else
		session[:error] = "You are not allowed to that."
		redirect "/teams/#{params[:slug]}"
	end
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

get '/login' do
	erb :login
end

get '/signup' do
	erb :signup
end

post '/signup' do
	name = params[:name]
	email = params[:email]
	password = BCrypt::Password.create(params[:password])

	user = User.create name: name, email: email, password_hash: password

	if user
		session[:user_id] = user.id
		redirect '/'
	else
		session[:error] = "You suck at creating users"
		redirect '/signup'
	end
end

post '/login' do
	email = params[:email]
	password = params[:password]

	user = User.find_by(email: email)

	password_hash = BCrypt::Password.new(user.password_hash) if user
	
	if user && password_hash == password
		session[:user_id] = user.id
	else 
		session[:error] = "Invalid credentials"
	end

	redirect '/'
end

get '/logout' do
	session.clear
	redirect '/'
end

get '/teams.json' do
	@teams = Team.all
	@teams.to_json
end

get '/users/:id' do
	@the_user = User.find(params[:id])

	if @user.id == @the_user.id || @user.admin
		erb :user
	else
		session[:error] = "You can't do that!"
		redirect '/teams'
	end
end
