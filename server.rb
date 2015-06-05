require 'bundler'
Bundler.setup

require_relative 'env'

require 'ostruct'
require 'date'
require 'pry'
require 'trello'
require 'sinatra'
require 'httparty'

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
  config.member_token = ENV['TRELLO_MEMBER_TOKEN']
end

TrelloConfig = Struct.new(:board, :list, :webhook_url)

board_mapper = ENV["SLACK_TRELLO_MAPPING"].split(';').map { |e| e.split(',') }.inject({}) do |memo, (channel_name, board_id, list_name, webhook_url)|
  memo[channel_name] = TrelloConfig.new(board_id, list_name, webhook_url)
  memo
end

post '/cards' do
  return 'Bad Slack Token' if params[:token] != ENV["SLACK_TOKEN"]

  config = board_mapper[params[:channel_name]]
  board = Trello::Board.find(config.board)
  lists = board.lists

  list = lists.detect { |l| l.name == config.list }

  card_name = params[:text].gsub('add ', '')

  card = Trello::Card.create({ name: card_name, list_id: list.id, pos: 'bottom' })

  "Created the card #{card.name} <#{card.url}> on #{board.name} > #{list.name}".tap do |result|
    HTTParty.post config.webhook_url, body: { text: result }.to_json if config.webhook_url
  end
end
