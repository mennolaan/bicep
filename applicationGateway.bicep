/*
*  parameters
*/

@description('The name of the application gateway within the specified resource group.')
param name string

@description('Azure Location for this application gateway deployment, uses resource group location by default.')
param location string = resourceGroup().location

@description('SKU of the application gateway. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewaysku')
param sku object = {
  name: 'WAF_v2'
  tier: 'WAF_v2'
  capacity: 1
}

@description('The type of identity used for the resource. The type \'SystemAssigned, UserAssigned\' includes both an implicitly created identity and a set of user assigned identities. The type \'None\' will remove any identities from the virtual machine.')
@allowed([
  'None'
  'SystemAssigned'
  'SystemAssigned, UserAssigned'
  'UserAssigned'
])
param identityType string = 'None'

@description('The list of user identities associated with resource.')
param userAssignedIdentities object = {}

@description('Subnets of the application gateway resource. For default limits, see Application Gateway limits. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayipconfiguration')
param gatewayIPConfigurations array = []

@description('SSL certificates of the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewaysslcertificate')
param sslCertificates array = []

@description('Authentication certificates of the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/applicationgateways?tabs=bicep#applicationgatewayauthenticationcertificate')
param authenticationCertificates array = []

@description('SSL profiles of the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewaysslprofile')
param sslProfiles array = []

@description('Trusted Root certificates of the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayprivatelinkconfiguration')
param trustedRootCertificates array = []

@description('Frontend ports of the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayfrontendport')
param frontendPorts array = []

@description('Frontend IP addresses of the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayfrontendipconfiguration')
param frontendIPConfigurations array = []

@description('Backend address pool of the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewaybackendaddresspool')
param backendAddressPools array = []

@description('Backend http settings of the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewaybackendhttpsettings')
param backendHttpSettingsCollection array = []

@description('Http listeners of the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayhttplistener')
param httpListeners array = []

@description('Probes of the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayprobe')
param probes array = []

@description('Request routing specifying redirect configuration. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayrequestroutingrule')
param requestRoutingRules array = []

@description('Rewrite rules for the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayrewriteruleset')
param rewriteRuleSets array = []

@description('URL path map of the application gateway resource.	Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayurlpathmap')
param urlPathMaps array = []

@description('Redirect configurations of the application gateway resource. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayredirectconfiguration')
param redirectConfigurations array = []

@description('Application Gateway Ssl policy. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewaysslpolicy')
param sslPolicy object = {}

@description('The type of the web application firewall rule set. Possible values are: \'OWASP\'.')
param ruleSetType string = 'OWASP'

@description('The version of the rule set type.')
param ruleSetVersion string = '3.0'

@description('PrivateLink configurations on application gateway. Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayprivatelinkconfiguration')
param privateLinkConfigurations array = []

@description('The disabled rule groups.	Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayfirewalldisabledrulegroup')
param webappFirewallDisabledRuleGroups array = []

@description('The exclusion list.	Ref: https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2021-03-01/applicationgateways?tabs=bicep#applicationgatewayfirewallexclusion')
param webappFirewallExclusions array = []

@description('object containing tag information')
param tags object = {}

/*
*  resource declaration
*/

var identity = identityType != 'None' ? {
  type: identityType
  userAssignedIdentities: !empty(userAssignedIdentities) ? userAssignedIdentities : null
} : null

resource applicationGateway 'Microsoft.Network/applicationGateways@2021-03-01' = {
  name: name
  location: location
  tags: tags
  identity: identity
  properties: {
    sku: sku
    gatewayIPConfigurations: gatewayIPConfigurations
    sslCertificates: sslCertificates
    trustedRootCertificates: trustedRootCertificates
    trustedClientCertificates: []
    authenticationCertificates: authenticationCertificates
    sslProfiles: sslProfiles
    frontendIPConfigurations: frontendIPConfigurations
    frontendPorts: frontendPorts
    backendAddressPools: backendAddressPools
    backendHttpSettingsCollection: backendHttpSettingsCollection
    httpListeners: httpListeners
    urlPathMaps: urlPathMaps
    requestRoutingRules: requestRoutingRules
    probes: probes
    rewriteRuleSets: rewriteRuleSets
    redirectConfigurations: redirectConfigurations
    privateLinkConfigurations: privateLinkConfigurations
    sslPolicy: sslPolicy
    webApplicationFirewallConfiguration: {
      ruleSetType: ruleSetType
      ruleSetVersion: ruleSetVersion
      enabled: true
      firewallMode: 'Prevention'
      disabledRuleGroups: webappFirewallDisabledRuleGroups
      exclusions: webappFirewallExclusions
      requestBodyCheck: true
      maxRequestBodySizeInKb: 128
      fileUploadLimitInMb: 100
    }
    enableHttp2: false
  }
}

output id string = applicationGateway.id
output name string = applicationGateway.name
