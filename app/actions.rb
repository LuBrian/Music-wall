# require('bootstrap')
# Homepage (Root path)

get '/' do
  erb :index
end


get '/messages' do
  @songs = Song.all
  # binding.pry
  erb :'messages/index'
end


get '/messages/new' do 
	halt 401, "not allowed" unless session[:admin]
	@song = Song.new
	erb :'messages/new'
end


get '/messages/:id' do
  @song = Song.find params[:id]
  erb :'messages/show'
end


get '/messages/:id/edit' do 
	@song = Song.find params[:id]
	halt 401, "not allowed" unless session[:admin] && session[:id] == @song.user_id
	erb :'messages/edit'
end


post '/messages' do
	# binding.pry
	@song = Song.new(
		Song_title: params[:song][:Song_title],
		Author: params[:song][:Author],
		URL: params[:song][:URL],
		user_id: session[:id]
	)
	if @song.save
		redirect '/messages'
	else
		erb :'messages/new'
	end
end

#when updating something specific
put '/messages/:id' do
  @song = Song.find params[:id]
  if @song.update_attributes(params[:song])
    redirect to("/messages/#{params[:id]}")
  else
    erb :"messages/#{params[:id]}/edit"
  end
end

delete '/messages/:id' do
  Song.find(params[:id]).destroy
  redirect to('/messages')
end

get '/login' do 
	erb :login
end


post '/login' do
	@user = User.find_by(user_name: params[:username], password: params[:password])

	if @user
		session[:id] = @user.id
		session[:admin] = true
		redirect to('/messages')
	else
		erb :login
	end
end

get '/logout' do 
	session.clear
	redirect to('/messages')
end


get '/signup' do 
	erb :signup
end

post '/signup' do 
	@user = User.new(
		user_name: params[:username],
		email: params[:email],
		password: params[:password]
	)
	if @user.save
		redirect '/'
	else
		erb :signup
	end
end

post '/messages/:id' do
	if Vote.where(user_id: session[:id], song_id: params[:id]).empty?
		@vote = Vote.new(
			user_id: session[:id],
			song_id: params[:id]
		)
		if @vote.save
			redirect to("/messages/#{params[:id]}")
		else
			puts 'vote unsuccessfully'
		end
	else
		halt 401, "You have vote this song"
	end
end











get '/users' do 
	@users = User.all
  erb :'messages/users'
end
# get '/setcookie' do 
# 	response.set_cookie 'foo' , 'bar'
# 	redirect to('/messages')
# end

# get '/readcookie' do 
# 	request.cookies['foo']
# end

# get'/deletecookie' do 
# 	request.delete_cookie['foo']
# 	redirect to
