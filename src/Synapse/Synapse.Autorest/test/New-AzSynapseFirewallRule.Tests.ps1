$loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
if (-Not (Test-Path -Path $loadEnvPath)) {
    $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
}
. ($loadEnvPath)
$TestRecordingFile = Join-Path $PSScriptRoot 'New-AzSynapseFirewallRule.Recording.json'
$currentPath = $PSScriptRoot
while(-not $mockingPath) {
    $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
    $currentPath = Split-Path -Path $currentPath -Parent
}
. ($mockingPath | Select-Object -First 1).FullName

Describe 'New-AzSynapseFirewallRule' {
    It 'CreateExpanded' {
        $name = "firewallrule-test-" + $env.rstr10
        $res = New-AzSynapseFirewallRule -ResourceGroupName $env.resourceGroup -WorkspaceName $env.testWorkspace1 -RuleName $name -StartIpAddress "200.0.0.0" -EndIpAddress "209.255.255.255"
        $res.Name | Should -Be $name
        { Remove-AzSynapseFirewallRule -ResourceGroupName $env.resourceGroup -WorkspaceName $env.testWorkspace1 -RuleName $name } | Should -Not -Throw
    }
}
