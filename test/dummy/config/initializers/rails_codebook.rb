RailsCodebook.redis = Redis.new(db:'15')

RailsCodebook.configure do |config|
  config.cb_key = 'cb'
  config.cb_data_path = ['config/locales/codebook/en.yml', 'test/dummy/config/locales/codebook/en.yml']
end

RailsCodebook::Engine.initialize_content