
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Updates a firewall rule.
.Description
Updates a firewall rule.
#>
function Update-AzSynapseFirewallRule {
    [OutputType([Microsoft.Azure.PowerShell.Cmdlets.Synapse.Models.Api20210301.IIPFirewallRuleInfo])]
    [CmdletBinding(DefaultParameterSetName = 'UpdateExpanded', PositionalBinding = $false, SupportsShouldProcess, ConfirmImpact = 'Medium')]
    param(
        [Parameter(ParameterSetName = 'UpdateExpanded', Mandatory, HelpMessage = "The name of the workspace.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Path')]
        [System.String]
        # The name of the workspace.
        ${WorkspaceName},

        [Parameter(ParameterSetName = 'UpdateExpanded', Mandatory, HelpMessage = "The name of the resource group.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Path')]
        [System.String]
        # The name of the resource group.
        # The name is case insensitive.
        ${ResourceGroupName},

        [Parameter(ParameterSetName = 'UpdateExpanded', Mandatory, HelpMessage = "The name of the firewall rule.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Path')]
        [System.String]
        # The name of the firewall rule.
        ${RuleName},

        [Parameter(ParameterSetName = 'UpdateExpanded', HelpMessage = "The ID of the target subscription.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Runtime.DefaultInfo(Script = '(Get-AzContext).Subscription.Id')]
        [System.String]
        # The ID of the target subscription.
        ${SubscriptionId},

        [Parameter(ParameterSetName = 'UpdateViaIdentityExpanded', Mandatory, ValueFromPipeline, HelpMessage = "Identity parameter. To construct, see NOTES section for INPUTOBJECT properties and create a hash table.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Path')]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Models.ISynapseIdentity]
        # Identity Parameter
        # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
        ${InputObject},

        [Parameter(HelpMessage = "The start IP address of the firewall rule.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Body')]
        [System.String]
        # The start IP address of the firewall rule.
        ${StartIPAddress},

        [Parameter(HelpMessage = "The end IP address of the firewall rule.")]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Body')]
        [System.String]
        # The end IP address of the firewall rule.
        ${EndIPAddress},

        [Parameter(HelpMessage = "The credentials, account, tenant, and subscription used for communication with Azure.")]
        [Alias('AzureRMContext', 'AzureCredential')]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Azure')]
        [System.Management.Automation.PSObject]
        # The credentials, account, tenant, and subscription used for communication with Azure.
        ${DefaultProfile},

        [Parameter(HelpMessage = "Run the command as a job")]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command as a job
        ${AsJob},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Wait for .NET debugger to attach
        ${Break},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be appended to the front of the pipeline
        ${HttpPipelineAppend},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Runtime')]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Runtime.SendAsyncStep[]]
        # SendAsync Pipeline Steps to be prepended to the front of the pipeline
        ${HttpPipelinePrepend},

        [Parameter(HelpMessage = "Run the command asynchronously")]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Run the command asynchronously
        ${NoWait},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Runtime')]
        [System.Uri]
        # The URI for the proxy server to use
        ${Proxy},

        [Parameter(DontShow)]
        [ValidateNotNull()]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Runtime')]
        [System.Management.Automation.PSCredential]
        # Credentials for a proxy server to use for the remote call
        ${ProxyCredential},

        [Parameter(DontShow)]
        [Microsoft.Azure.PowerShell.Cmdlets.Synapse.Category('Runtime')]
        [System.Management.Automation.SwitchParameter]
        # Use the default credentials for the proxy
        ${ProxyUseDefaultCredentials}
    )

    process {
        try {
            # 1. GET
            $hasStartIPAddress = $PSBoundParameters.Remove('StartIPAddress')
            $hasEndIPAddress = $PSBoundParameters.Remove('EndIPAddress')
            $hasAsJob = $PSBoundParameters.Remove('AsJob')
            $null = $PSBoundParameters.Remove('RuleName')
            $null = $PSBoundParameters.Remove('WhatIf')
            $null = $PSBoundParameters.Remove('Confirm')

            $workspace = Get-AzSynapseFirewallRule @PSBoundParameters

            # 2. PUT
            $isViaIdentity = $PSBoundParameters.Remove('InputObject')
            $null = $PSBoundParameters.Remove('WorkspaceName')
            $null = $PSBoundParameters.Remove('ResourceGroupName')
            $null = $PSBoundParameters.Remove('SubscriptionId')

            $hasRule = $false
            $getStartIPAddress
            $getEndIPAddress
            if (!$isViaIdentity) {
                for ($i = 0; $i -lt $workspace.Count; $i++) {
                    if (!$workspace.Name[$i].CompareTo($RuleName)) {
                        $hasRule = $true
                        $getStartIPAddress = $workspace[$i].StartIpAddress
                        $getEndIPAddress = $workspace[$i].EndIpAddress
                    }
                }
            } else {
                if ($workspace.Count -gt 0) {
                    $hasRule = $true
                    $getStartIPAddress = $workspace.StartIpAddress
                    $getEndIPAddress = $workspace.EndIpAddress
                }
            }
            

            if ($hasRule) {
                if ($hasStartIPAddress) {
                    $getStartIPAddress = $StartIPAddress
                }
                if ($hasEndIPAddress) {
                    $getEndIPAddress = $EndIPAddress
                }
                if ($hasAsJob) {
                    $PSBoundParameters.Add('AsJob', $true)
                }
                if ($PSCmdlet.ShouldProcess("Firewall rule $($RuleName) from workspace $($WorkspaceName)", "Create or update")) {
                    if ($isViaIdentity) {
                        $getWorkspaceName = $workspace.Id.split("/")[8]
                        $getResourceGroupName = $workspace.Id.split("/")[4]
                        $getFirewallRuleName = $workspace.Id.split("/")[10]
                        New-AzSynapseFirewallRule -WorkspaceName $getWorkspaceName -ResourceGroupName $getResourceGroupName -RuleName $getFirewallRuleName -StartIpAddress $getStartIPAddress -EndIPAddress $getEndIPAddress @PSBoundParameters
                    } else {
                        New-AzSynapseFirewallRule -WorkspaceName $WorkspaceName -ResourceGroupName $ResourceGroupName -RuleName $RuleName -StartIpAddress $getStartIPAddress -EndIPAddress $getEndIPAddress @PSBoundParameters
                    }
                }
            } else {
                Write-Error -Message "No firewall rule named $RuleName in workspace $WorkspaceName." -Category InvalidArgument
            } 
        }
        catch {
            throw
        }
    }
}