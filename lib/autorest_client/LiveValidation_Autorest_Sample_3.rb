require 'azure_live_validation'

include Livevalidation
include Livevalidation::Models

live_validation_service_client = LiveValidationServiceClient.new

live_request = LiveRequest.new
live_request.method = 'PUT'
live_request.url = "/subscriptions/4d368445-cbb1-42a7-97a6-6850ab99f48e/resourceGroups/pslibtest9279/providers/Microsoft.Compute/virtualMachines/vm1827?api-version=2017-12-01"
live_request.headers = {
    "Content-Type": "application/json; charset=utf-8",
    "Content-Length": "2687",
    "x-ms-client-request-id": "907b1d69-63aa-473e-8050-b7dd266a4f81",
    "accept-language": "en-US",
    "User-Agent": "Microsoft.Azure.Management.Compute.ComputeManagementClient/9.0.0.0"
}
live_request.body = {
    "location": "SoutheastAsia",
    "tags": {
        "RG": "rg",
        "testTag": "1"
    },
    "properties": {
        "hardwareProfile": {
            "vmSize": "Standard_A0"
        },
        "storageProfile": {
            "imageReference": {
                "publisher": "MicrosoftWindowsServer",
                "offer": "WindowsServer",
                "sku": "2012-R2-Datacenter",
                "version": "4.0.201505"
            },
            "osDisk": {
                "name": "test",
                "vhd": {
                    "uri":
                        "https://pslibtest475.blob.core.windows.net/pslibtest1846/ospslibtest7802.vhd"
                },
                "caching": "None",
                "createOption": "fromImage"
            }
        },
        "osProfile": {
            "computerName": "test",
            "adminUsername": "Foo12",
            "adminPassword": "[PLACEHOLDER]",
            "customData": "ZWNobyAnSGVsbG8gV29ybGQn",
            "windowsConfiguration": {
                "provisionVMAgent": true,
                "enableAutomaticUpdates": false,
                "timeZone": "Pacific Standard Time",
                "additionalUnattendContent": [
                    {
                        "passName": "oobeSystem",
                        "componentName": "Microsoft-Windows-Shell-Setup",
                        "settingName": "AutoLogon",
                        "content":
                            "<AutoLogon><Enabled>true</Enabled><LogonCount>5</LogonCount><Username>Foo12</Username><Password><Value>[PLACEHOLDER]</Value><PlainText>true</PlainText></Password></AutoLogon>"
                    }
                ],
                "winRM": {
                    "listeners": [
                        {
                            "protocol": "Http"
                        },
                        {
                            "protocol": "Https",
                            "certificateUrl":
                                "https://pslibtestkeyvault.vault.azure.net/secrets/WinRM/24c727e7449b47cb9d2f385113f59a63"
                        }
                    ]
                }
            },
            "secrets": [
                {
                    "sourceVault": {
                        "id":
                            "/subscriptions/ccfebd33-45cd-4e22-9389-98982441aa5d/resourceGroups/pslibtestosprofile/providers/Microsoft.KeyVault/vaults/pslibtestkeyvault"
                    },
                    "vaultCertificates": [
                        {
                            "certificateUrl":
                                "https://pslibtestkeyvault.vault.azure.net/secrets/WinRM/24c727e7449b47cb9d2f385113f59a63",
                            "certificateStore": "My"
                        }
                    ]
                }
            ]
        },
        "networkProfile": {
            "networkInterfaces": [
                {
                    "id":
                        "/subscriptions/4d368445-cbb1-42a7-97a6-6850ab99f48e/resourceGroups/pslibtest9279/providers/Microsoft.Network/networkInterfaces/azsmnet504"
                }
            ]
        },
        "availabilitySet": {
            "id":
                "/subscriptions/4d368445-cbb1-42a7-97a6-6850ab99f48e/resourceGroups/pslibtest9279/providers/Microsoft.Compute/availabilitySets/as9002"
        }
    }
}

live_response = LiveResponse.new
live_response.status_code = "403"
live_response.headers = {
    "Content-Length": "628",
    "Content-Type": "application/json; charset=utf-8",
    "Expires": "-1",
    "Pragma": "no-cache",
    "x-ms-failure-cause": "gateway",
    "x-ms-request-id": "72f02558-fb2f-4763-83bd-eca1ec25e520",
    "x-ms-correlation-request-id": "72f02558-fb2f-4763-83bd-eca1ec25e520",
    "x-ms-routing-request-id": "WESTUS:20150805T231502Z:72f02558-fb2f-4763-83bd-eca1ec25e520",
    "Strict-Transport-Security": "max-age=31536000; includeSubDomains",
    "Connection": "close",
    "Cache-Control": "no-cache",
    "Date": "Wed, 05 Aug 2015 23:15:01 GMT"
}
live_response.body = {
    "error": {
        "code": "LinkedAuthorizationFailed",
        "message":
            "The client 'phuang@microsoft.com' with object id 'f6bde659-aae5-4ba4-8da2-8d07610f7210' has permission to perform action 'Microsoft.Compute/virtualMachines/write' on scope '/subscriptions/4d368445-cbb1-42a7-97a6-6850ab99f48e/resourceGroups/pslibtest9279/providers/Microsoft.Compute/virtualMachines/vm1827'; however, it does not have permission to perform action 'Microsoft.KeyVault/vaults/deploy/action' on the linked scope(s) '/subscriptions/ccfebd33-45cd-4e22-9389-98982441aa5d/resourceGroups/pslibtestosprofile/providers/Microsoft.KeyVault/vaults/pslibtestkeyvault'."
    }
}

live_validation_parameter = LiveValidationParameter.new
live_validation_parameter.live_request = live_request
live_validation_parameter.live_response = live_response

validation_response = live_validation_service_client.tools.live_validation_validate live_validation_parameter

puts 'Validation Results'
puts '=================='
puts '  Request Validation Results'
puts '  =========================='
puts "    Successful Request: #{validation_response.request_validation_result.successful_request}"
puts '    Errors'
puts '    ======'
puts '      No Errors' if validation_response.request_validation_result.errors.length == 0
validation_response.request_validation_result.errors.each do |error|
  error.each do |key, value|
    puts "      #{key} : #{value}"
  end
end
puts '    Operation Info'
puts '    =============='
puts '      No Operation Info' if validation_response.request_validation_result.operation_info.length == 0
validation_response.request_validation_result.operation_info.each do |op_info|
  op_info.each do |key, value|
    puts "      #{key} : #{value}"
  end
end
puts
puts '  Response Validation Results'
puts '  =========================='
puts "    Successful Response: #{validation_response.response_validation_result.successful_response}"
puts '    Errors'
puts '    ======'
puts '      No Errors' if validation_response.response_validation_result.errors.length == 0
validation_response.response_validation_result.errors.each do |error|
  error.each do |key, value|
    puts "      #{key} : #{value}"
  end
end
puts '    Operation Info'
puts '    =============='
puts '      No Operation Info' if validation_response.response_validation_result.operation_info.length == 0
validation_response.response_validation_result.operation_info.each do |op_info|
  op_info.each do |key, value|
    puts "      #{key} : #{value}"
  end
end
