require 'azure_live_validation'

live_validation_service_client = Livevalidation::LiveValidationServiceClient.new
whitelist_response = live_validation_service_client.tools.live_validation_white_list
whitelist_response.safe_properties.each do |key, value|
  puts "Key: #{key}"
  value.each do |key_value|
    puts "  #{key_value}"
  end
end