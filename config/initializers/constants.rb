#config/initializers/constants.rb
s3_config_file = File.join(Rails.root,'config','amazon_s3.yml')
raise "#{s3_config_file} is missing!" unless File.exists? s3_config_file

S3_CONFIG = YAML.load_file("#{::Rails.root}/config/amazon_s3.yml")