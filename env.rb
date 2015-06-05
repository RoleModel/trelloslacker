# Local override
dotenv = File.expand_path("../.env_overrides.rb", __FILE__)
require dotenv if File.exist?(dotenv)

ENV["TRELLO_DEVELOPER_PUBLIC_KEY"] ||= ""
ENV["TRELLO_MEMBER_TOKEN"]         ||= ""
ENV["SLACK_TOKEN"]                 ||= ""
ENV["SLACK_TRELLO_MAPPING"]        ||= ""
