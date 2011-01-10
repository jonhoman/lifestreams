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
end
