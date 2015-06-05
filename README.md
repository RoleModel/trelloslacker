# Trelloslacker

Simple bot that support a slash command to add cards to a configured trello board.

## ENV Configuration

### Trello Keys

1. Get your API keys from trello.com/app-key.
2. Visit the URL [trello.com/1/authorize], with the following GET parameters:
  * key: the API key you got in step 1.
  * response_type: "token"
  * expiration: "never" if you don't want your token to ever expire. If you leave this blank, your generated token will expire after 30 days.
  * The URL will look like this: https://trello.com/1/authorize?key=YOURAPIKEY&response_type=token&expiration=never&scope=read,write

You should see a page asking you to authorize your Trello application. Click "allow" and you should see a second page with a long alphanumeric string. This is your member token.

```ruby
ENV["TRELLO_DEVELOPER_PUBLIC_KEY"] ||= "1ba349cc9d773c4381470cd6e52d17a6"
ENV["TRELLO_MEMBER_TOKEN"]         ||= "617b90630274905fcd67b0e553a8cc0e39d380773aef4a7653a80c7cc8152af3"
```

### Slack slash command token

```ruby
ENV["SLACK_TOKEN"] ||= "hj344g4oOiNaRJOq6lVwmnZI"
```

### Slack Trello Mapping

The configuration of the slash command expects a list of: slack_channel_id,
trello_board_id, trello_list_name with each entry separated by a `;`.

```ruby
ENV["SLACK_TRELLO_MAPPING"] ||= "trello,ujuAD321,Proposed Ideas;general,ujuCZb8i,Backlog"
```

Optionally you can provide a `webhook_url` as a 4th parameter that will be used to post back to Slack.

```ruby
ENV["SLACK_TRELLO_MAPPING"] ||= "trello,ujuAD321,Backlog,https://hooks.slack.com/services/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"
```
