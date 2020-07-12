class Messenger
  def initialize(_how, to, name = nil)
    @notifier = Slack::Notifier.new(
      ENV['SLACK_WEBHOOK_URL'],
      channel: to,
      username: name,
      link_names: 1
    )
  end

  def push!(message, options = {})
    unless Rails.env.production?
      Rails.logger.debug(message)
      return
    end
    @notifier.ping(message, options)
  rescue Net::OpenTimeout, Net::HTTPGatewayTimeOut
    raise 'Slack Connection Error'
  end
end
