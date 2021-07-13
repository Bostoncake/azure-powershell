### Example 1: Remove a firewall rule from a workspace
```powershell
PS C:\> Remove-AzSynapseFirewallRule -ResourceGroupName firewallrule -WorkspaceName firewallruletest -RuleName allowUser3
```

This command removes firewall rule named allowUser3 from workspace firewallruletest under resource group firewallrule.
