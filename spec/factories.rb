FactoryGirl.define do
  factory :user do
    email                 'test@example.com'
    password              'password'
    password_confirmation 'password'
  end
  
  factory :twitter_account do
    handle              "test" 
    access_token        "asdf" 
    access_token_secret "asdf"
  end

  factory :feed do
    name "example feed"
    url  "http://tanyahoman.com"
  end

  factory :stream do
    name "example stream"
  end

  factory :item do
    title          "example item"
    published_date DateTime.now
  end
end
