require 'sinatra'
require 'data_mapper'
require 'mysql'
require 'dm-mysql-adapter'

DataMapper.setup(
	:default,
	'mysql://root@localhost/hand_blog'
)

class Hand
	include DataMapper::Resource
	property :id, Serial
	property :title, String
	property :url, String
	property :description, String
end

DataMapper.finalize.auto_upgrade!

get '/' do
		@hands = Hand.all 
		erb :index
end


get '/hand/:id' do
	@hand = Hand.get params[:id]
	erb :display_hand
end


get '/new' do
	erb :create_hand_info
end


post '/create_hand' do
	p params
	@hand = Hand.new
	@hand.title = params[:title]
	@hand.url = params[:url]
	@hand.description = params[:description]
	@hand.save
	redirect to '/'

end


delete '/delete_hand/:id' do
	@hand = Hand.get params[:id]
	@hand.destroy
	redirect to '/'
end

