require 'sinatra'
require 'data_mapper'


DataMapper.setup(
	:default,
	'mysql://root@localhost/stammtisch'
)

class Member
	include DataMapper::Resource
	property :id, Serial
	property :name, String
	property :email, String
	property :number, String
end

DataMapper.finalize.auto_upgrade!

get '/' do 
	@members = Member.all
	erb :index, layout: :layout
end

get '/newmember' do
	erb :new_member, layout: :layout
end

post '/new_member' do
	p params
	@member = Member.new
	@member.name = params[:name]
	@member.email = params[:email]
	@member.number = params[:number]
	@member.save
	redirect to '/'
end

get '/member/:id' do
	@member = Member.get params[:id]
	erb :display_members
end

delete '/delete_member/:id' do 
	@member = Member.get params[:id]
	@member.destroy
	redirect to '/'
end

get '/updatemember/:id' do 
	@member = Member.get params[:id]
	erb :update_member
end




