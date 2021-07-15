### Example 1: List all firewall rules under a workspace
```powershell
PS C:\> Get-AzSynapseFirewallRule -ResourceGroupName firewallrule -WorkspaceName firewallruletest

Name                           Start IP Address     End IP Address
----                           ----------------     --------------
allowAll                       0.0.0.0              255.255.255.255
allowUser1                     100.0.0.0            109.255.255.255
allowUser2                     110.0.0.0            119.255.255.255
```

This command lists all firewall rules under workspace firewallruletest from resource group firewallrule.

### Example 2: Get a firewall rule by name
```powershell
PS C:\> Get-AzSynapseFirewallRule -ResourceGroupName firewallrule -WorkspaceName firewallruletest -RuleName allowAll

Name                           Start IP Address     End IP Address
----                           ----------------     --------------
allowAll                       0.0.0.0              255.255.255.255
```

This command lists firewall rule allowAll under workspace firewallruletest from resource group firewallrule.

### Example 3: Get a firewall rule by pipeline

```powershell
PS C:\> $fwr = New-AzSynapseFirewallRule -ResourceGroupName firewallrule -WorkspaceName firewallruletest -RuleName allowUser4 -StartIPAddress 200.0.0.0 -EndIPAddress 209.255.255.255
PS C:\> Get-AzSynapseFirewallRule -InputObject $fwr

Name                           Start IP Address     End IP Address
----                           ----------------     --------------
allowUser4                     200.0.0.0            209.255.255.255
```

This command gets a firewall rule allowUser4 under workspace firewallruletest from resource group firewallrule through pipeline.
