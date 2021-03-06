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

  factory :email_list do
    name "example email list"
  end

  factory :facebook_account do
    name "Facebook Account"
    access_token "asdf"
  end

  factory :recipient do
    email_address "me@google.com"
  end
end
