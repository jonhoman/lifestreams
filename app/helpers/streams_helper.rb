module StreamsHelper
  def determine_selected_feed
    @stream.feed ? @stream.feed.id : nil
  end

  def determine_selected_twitter_account
    @stream.twitter_account ? @stream.twitter_account.id : nil
  end
end
