### Example 1: Create a firewall rule under a workspace
```powershell
PS C:\> New-AzSynapseFirewallRule -ResourceGroupName firewallrule -WorkspaceName firewallruletest -RuleName allowUser3 -StartIPAddress 120.0.0.0 -EndIPAddress 129.255.255.255

Name                           Start IP Address     End IP Address
----                           ----------------     --------------
allowUser3                     120.0.0.0            129.255.255.255
```

This command creates a firewall rule named allowUser3 under workspace allowUser3 from resource group firewallrule.

### Example 2: Create a firewall rule allowing all IP under a workspace
```powershell
PS C:\> New-AzSynapseFirewallRule -ResourceGroupName firewallrule -WorkspaceName firewallruletest -RuleName allowUser6 -AllowAllIp

Name                           Start IP Address     End IP Address
----                           ----------------     --------------
allowUser6                     0.0.0.0              255.255.255.255
```

This command creates a firewall rule named allowUser3 under workspace allowUser3 from resource group firewallrule.
