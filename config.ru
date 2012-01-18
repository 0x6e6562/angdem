require 'bundler/setup'
Bundler.require(:default)

require 'logger'
require 'sequel'
require 'mysql2'
require 'securerandom'
require 'bcrypt'

use Rack::Session::Cookie,  :key => 'rack.session',
                            :path => '/',
                            :expire_after => 600, # In seconds
                            :secret => 'change_me'

# Load in the main router 
require File.dirname(__FILE__) + "/rhy.rb"

# Fire up the DB
DB = Sequel.connect(
  :adapter  => 'mysql2',
  :host     => '127.0.0.1',
  :port     => 3306,
  :database => 'rhy',
  :user     => 'rhy_user',
  :password => 'rhy_user',
  :test     => true
)

# load DB models
Dir['models/*.rb'].each {|file| require "./#{file}"}

# User.create(id: 'abc', 
#             password: 'secret',
#             email: 'foo@bar.com', 
#             member_since: DateTime.now)
            #activation_key: SecureRandom.hex(32))

Warden::Manager.serialize_into_session{|user| user.id }
Warden::Manager.serialize_from_session{|id| User.get(id) }

Warden::Manager.before_failure do |env,opts|
  env['REQUEST_METHOD'] = "POST"
end

Warden::Strategies.add(:password) do

  def valid?
    params["username"] || params["password"]
  end

  def authenticate!
    user = User.authenticate(params['username'], params['password'])
    user.nil? ? fail!('Could not log in') : success!(user, 'Successfully logged in')    
  end
  
end

use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = Rhy
end

map '/' do
  run Rhy
end
