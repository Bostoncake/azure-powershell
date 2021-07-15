### Example 1: Remove a firewall rule from a workspace
```powershell
PS C:\> Remove-AzSynapseFirewallRule -ResourceGroupName firewallrule -WorkspaceName firewallruletest -RuleName allowUser3
```

This command removes firewall rule named allowUser3 from workspace firewallruletest under resource group firewallrule.

### Example 2: Remove a firewall rule from a workspace through pipeline

```powershell
PS C:\> $fwr = New-AzSynapseFirewallRule -ResourceGroupName firewallrule -WorkspaceName firewallruletest -RuleName allowUser5 -StartIPAddress 200.0.0.0 -EndIPAddress 209.255.255.255
PS C:\> Remove-AzSynapseFirewallRule -InputObject $fwr
```

This command removes firewall rule named allowUser5 from workspace firewallruletest under resource group firewallrule through pipeline.

