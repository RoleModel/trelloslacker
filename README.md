# Trelloslacker

Simple bot that support a slash command to add cards to a configured trello board.

## Heroku Congiuration

The configuration of the slash command expects a list of: slack_channel_id,
trello_board_id, trello_list_name with each entry separated by a `;`.

```ruby
ENV["SLACK_TRELLO_MAPPING"] ||= "trello,ujuAD321,Proposed Ideas;general,ujuCZb8i,Backlog"
```

Optionally you can provide a `webhook_url` as a 4th parameter that will be used to post back to Slack.

```ruby
ENV["SLACK_TRELLO_MAPPING"] ||= "trello,ujuAD321,Backlog,https://hooks.slack.com/services/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"
```
