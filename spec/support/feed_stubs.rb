module FeedStubs
  def fixture
    File.new("#{Rails.root}/spec/data/tanyahoman.html")
  end

  def stub_url_request!
    stub_request(:get, "http://tanyahoman.com/").
      with(:headers => {'Accept'=>'*/*'}).
      to_return(:status => 200, :body => "", :headers => {})

  end
end
