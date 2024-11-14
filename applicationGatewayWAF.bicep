/*
*  parameters
*/

@description('The name of the WAF rule.')
param name string

@description('Azure Location for this applicationGatewayWebApplicationFirewallPolicies deployment, uses resource group location by default.')
param location string = resourceGroup().location

@description('Define the object tag information.')
param tags object = {}

@description('The custom rules inside the policy.')
param customRules array = []

@description('The Exclusions that are applied on the policy.')
param exclusions array = []

@description('Defines the rule group overrides to apply to the rule set.')
param ruleGroupOverrides array = []

@description('Defines the rule set type to use.')
param ruleSetType string

@description('Defines the rule set version to use.')
param ruleSetVersion string

@description('Maximum file upload size in Mb for WAF.')
param fileUploadLimitInMb int

@description('Maximum request body size in Kb for WAF.')
param maxRequestBodySizeInKb int

@description('The mode of the policy.')
@allowed([
  'Detection'
  'Prevention'
])
param mode string

@description('Whether to allow WAF to check request Body.')
param requestBodyCheck bool=true

@description('The state of the policy.')
@allowed([
  'Disabled'
  'Enabled'
])
param state string

/*
*  resource declaration
*/

resource applicationGatewayWebApplicationFirewallPolicies_main 'Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies@2021-08-01' = {
  name: name
  location: location
  tags: tags
   properties: {
    customRules: customRules
    managedRules: {
      exclusions: exclusions
      managedRuleSets: [
        {
          ruleGroupOverrides: ruleGroupOverrides
          ruleSetType: ruleSetType
          ruleSetVersion: ruleSetVersion
        }
      ]
    }
    policySettings: {
      fileUploadLimitInMb: fileUploadLimitInMb
      maxRequestBodySizeInKb: maxRequestBodySizeInKb
      mode: mode
      requestBodyCheck: requestBodyCheck
      state: state
    }
  }
}
  
output id string = applicationGatewayWebApplicationFirewallPolicies_main.id
output name string = applicationGatewayWebApplicationFirewallPolicies_main.name

