Jumpup::Heroku.configure do |config|
  config.app = 'chirrup'
end if Rails.env.development?
