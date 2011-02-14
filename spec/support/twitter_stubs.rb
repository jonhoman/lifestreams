module TwitterStubs
  def stub_oauth_request_token!
    stub_request(:post, "https://api.twitter.com/oauth/request_token").to_return(:body => "oauth_token=t&oauth_token_secret=s")
  end

  def stub_oauth_access_token!
    stub_request(:post, "https://api.twitter.com/oauth/access_token").to_return(:body => "oauth_token=at&oauth_token_secret=as&screen_name=sn")
  end
end
