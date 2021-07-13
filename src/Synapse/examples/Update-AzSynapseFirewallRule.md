### Example 1: Update a firewall rule from a workspace
```powershell
PS C:\> Remove-AzSynapseFirewallRule -ResourceGroupName firewallrule -WorkspaceName firewallruletest -RuleName allowUser3 -StartIPAddress 121.0.0.0 -EndIPAddress 130.255.255.255
```

This command updates start ip address and end ip address for firewall rule named allowUser3 from workspace firewallruletest under resource group firewallrule.

