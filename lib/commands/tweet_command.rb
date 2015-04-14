require 'commands/base_tweet_command'
require 'fileutils'
require 'tweets/status_publisher'
require 'tweets/media_status_publisher'
require 'tweets/status_persister'
require 'tweets/media_status_persister'

class TweetCommand
  attr_reader :publisher, :persister

  def initialize(tweet, image_path=nil)
    super()

    if image_path
      @publisher = MediaStatusPublisher.new(tweet, image_path)
      @persister = MediaStatusPersister.new(image_path)
    else
      @publisher = StatusPublisher.new(tweet)
      @persister = StatusPersister.new
    end
  end

  def execute
    persister.persist(publisher.publish)
  end
end
