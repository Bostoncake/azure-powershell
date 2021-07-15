<!-- region Generated -->
# Az.Synapse
This directory contains the PowerShell module for the Synapse service.

---
## Status
[![Az.Synapse](https://img.shields.io/powershellgallery/v/Az.Synapse.svg?style=flat-square&label=Az.Synapse "Az.Synapse")](https://www.powershellgallery.com/packages/Az.Synapse/)

## Info
- Modifiable: yes
- Generated: all
- Committed: yes
- Packaged: yes

---
## Detail
This module was primarily generated via [AutoRest](https://github.com/Azure/autorest) using the [PowerShell](https://github.com/Azure/autorest.powershell) extension.

## Module Requirements
- [Az.Accounts module](https://www.powershellgallery.com/packages/Az.Accounts/), version 2.2.3 or greater

## Authentication
AutoRest does not generate authentication code for the module. Authentication is handled via Az.Accounts by altering the HTTP payload before it is sent.

## Development
For information on how to develop for `Az.Synapse`, see [how-to.md](how-to.md).
<!-- endregion -->

### AutoRest Configuration
> see https://aka.ms/autorest

``` yaml
Branch: 9622c4ff423c2b9ecd42126fe30c575201cbe62e
require:
# readme.azure.noprofile.md is the common configuration file
  - $(this-folder)/../../readme.azure.noprofile.md
input-file:
# You need to specify your swagger files here.
#  - $(repo)/specification/synapse/resource-manager/Microsoft.Synapse/stable/2021-03-01/bigDataPool.json
  - $(repo)/specification/synapse/resource-manager/Microsoft.Synapse/stable/2021-03-01/firewallRule.json
#  - $(repo)/specification/synapse/resource-manager/Microsoft.Synapse/stable/2021-03-01/integrationRuntime.json
#  - $(repo)/specification/synapse/resource-manager/Microsoft.Synapse/stable/2021-03-01/sqlPool.json
#  - $(repo)/specification/synapse/resource-manager/Microsoft.Synapse/stable/2021-03-01/workspace.json
#  - $(repo)/specification/synapse/resource-manager/Microsoft.Synapse/stable/2021-03-01/keys.json
#  - $(repo)/specification/synapse/resource-manager/Microsoft.Synapse/stable/2021-03-01/privatelinkhub.json

# If the swagger has not been put in the repo, you may uncomment the following line and refer to it locally
# - (this-folder)/relative-path-to-your-swagger 

# For new RP, the version is 0.1.0
module-version: 0.1.0
# Normally, title is the service name
title: Synapse
subject-prefix: $(service-name)

# If there are post APIs for some kinds of actions in the RP, you may need to 
# uncomment following line to support viaIdentity for these post APIs
# identity-correction-for-post: true

directive:
  # Following is two common directive which are normally required in all the RPs
  # 1. Remove the unexpanded parameter set
  # 2. For New-* cmdlets, ViaIdentity is not required, so CreateViaIdentityExpanded is removed as well

  # Change firewall rules related command name from IPFirewallRule to FirewallRule
  - where:
      subject: IPFirewallRule
    set:
      subject: FirewallRule
  
  # Remove original Update command using ReplaceAll API
  - where:
      verb: Update
      subject: FirewallRule
    remove: true
      
  # Change firewall rules output format
  - where:
      model-name: ^IPFirewallRule(.*)
    set:
      format-table:
        properties:
          - Name
          - StartIPAddress
          - EndIPAddress
        labels:
          StartIPAddress: Start IP Address
          EndIPAddress: End IP Address
        width:
          Name: 30
          StartIPAddress: 20
          EndIPAddress: 20
  
  # Change LRO options for CreateOrUpdate API
  - from: firewallRule.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Synapse/workspaces/{workspaceName}/firewallRules/{ruleName}"].put
    transform: delete $["x-ms-long-running-operation-options"]
    
  - where:
      variant: ^Create$|^CreateViaIdentity$|^CreateViaIdentityExpanded$|^Update$|^UpdateViaIdentity$
    remove: true
  # Remove the set-* cmdlet
  - where:
      verb: Set
    remove: true
  - from: integrationRuntime.json
    where: $..[?(@.properties)]
    transform: delete $.additionalProperties

```
