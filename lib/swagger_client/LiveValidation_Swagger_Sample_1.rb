require 'swagger_client'

api_client = SwaggerClient::ApiClient.new
live_validation_api =  SwaggerClient::LiveValidationApi.new api_client
whitelist_response = live_validation_api.tools_live_validation_white_list
whitelist_response.safe_properties.each do |key, value|
  puts "Key: #{key}"
  value.each do |key_value|
    puts "  #{key_value}"
  end
end