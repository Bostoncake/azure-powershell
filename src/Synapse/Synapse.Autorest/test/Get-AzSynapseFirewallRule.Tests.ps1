$loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
if (-Not (Test-Path -Path $loadEnvPath)) {
    $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
}
. ($loadEnvPath)
$TestRecordingFile = Join-Path $PSScriptRoot 'Get-AzSynapseFirewallRule.Recording.json'
$currentPath = $PSScriptRoot
while(-not $mockingPath) {
    $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
    $currentPath = Split-Path -Path $currentPath -Parent
}
. ($mockingPath | Select-Object -First 1).FullName

Describe 'Get-AzSynapseFirewallRule' {
    It 'List' -skip {
        $firewallRules = Get-AzSynapseFirewallRule -ResourceGroupName $env.resourceGroup -WorkspaceName $env.testWorkspace1
        $firewallRules.Count | Should -Be 3
    }

    It 'Get' -skip {
        $firewallRule = Get-AzSynapseFirewallRule -ResourceGroupName $env.resourceGroup -WorkspaceName $env.testWorkspace1 -RuleName $env.firewallRule1Name
        $firewallRule.StartIPAddress | Should -Be $env.firewallRule1Start
        $firewallRule.EndIPAddress | Should -Be $env.firewallRule1End
    }

    It 'GetViaIdentity' -skip {
        $firewallRulePipein = (Get-AzSynapseFirewallRule -ResourceGroupName $env.resourceGroup -WorkspaceName $env.testWorkspace1 -RuleName $env.firewallRule1Name )
        $firewallRule = Get-AzSynapseFirewallRule -InputObject $firewallRulePipein
        $firewallRule.StartIPAddress | Should -Be $env.firewallRule1Start
        $firewallRule.EndIPAddress | Should -Be $env.firewallRule1End
    }
}
