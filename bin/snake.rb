require 'pry'
require 'json'
require 'rails'

hash = JSON(File.read(ARGV[0]))
new_hash = hash.deep_transform_keys{ |key| key.to_s.underscore }

new_json = JSON.pretty_generate(new_hash)

File.open(ARGV[0], "wb") { |f| f.write(new_json) }
