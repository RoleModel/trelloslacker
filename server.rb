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

board_mapper = {
  'trello' => TrelloConfig.new('ujuCZb8i', 'Proposed Ideas', 'https://hooks.slack.com/services/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')
}

post '/cards' do
  return 'Bad Slack Token' if params[:token] != ENV["SLACK_TOKEN"]

  config = board_mapper[params[:channel_name]]
  board = Trello::Board.find(config.board)
  lists = board.lists

  list = lists.detect { |l| l.name == config.list }

  card_name = params[:text].gsub('add ', '')

  card = Trello::Card.create({ name: card_name, list_id: list.id, pos: 'bottom' })

  "Created the card #{card.name} <#{card.url}> on #{board.name} > #{list.name}".tap do |result|
    HTTParty.post config.webhook_url, body: { text: result }.to_json
  end
end
