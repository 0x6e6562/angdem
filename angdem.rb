class Angdem < Sinatra::Base
  
  helpers do
    def protected!        
      unless env['warden'].user
        throw(:halt, [401, "Not authorized\n"])          
      end
    end
  end
  
  set :session_secret, "some big secret"
  
  get '/' do
    send_file File.join(settings.public_folder, 'index.html')
  end
  
  get '/logout/?' do
    puts 'logging out'
    env['warden'].logout
    response.set_cookie('username', {:value => nil, :expires => Time.now - 24 * 60 * 60})
    status 204
  end
  
  post '/login' do
    env['warden'].authenticate!
    response.set_cookie('username', env['warden'].user.id)
    status 204
  end
  
  post '/unauthenticated/?' do
    status 401
  end
  
  get '/signup/exists/:identifier' do
    name = params[:identifier]
    unused = User.filter({:id => name} | {:email => name}).empty?
    (!unused).to_s
  end
  
  get '/activate/:code' do
    begin
      Activation[params[:code]].delete
      status 204
    rescue
      status 404
    end
  end
  
  post '/signup/:username/:email/:password' do
    timestamp = DateTime.now
    user = User.create(id:           params[:username], 
                       password:     BCrypt::Password.create(params[:password]),
                       email:        params[:email], 
                       member_since: timestamp)
    
    activation = Activation.create(code:       SecureRandom.hex(32),
                                   user_id:    user.id,
                                   created_at: timestamp)            

    status 201
  end
  
  get '/test' do
    protected!
    "Welcome, authenticated client"
  end
  
end