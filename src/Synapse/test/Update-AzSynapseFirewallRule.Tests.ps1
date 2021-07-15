$loadEnvPath = Join-Path $PSScriptRoot 'loadEnv.ps1'
if (-Not (Test-Path -Path $loadEnvPath)) {
    $loadEnvPath = Join-Path $PSScriptRoot '..\loadEnv.ps1'
}
. ($loadEnvPath)
$TestRecordingFile = Join-Path $PSScriptRoot 'Update-AzSynapseFirewallRule.Recording.json'
$currentPath = $PSScriptRoot
while(-not $mockingPath) {
    $mockingPath = Get-ChildItem -Path $currentPath -Recurse -Include 'HttpPipelineMocking.ps1' -File
    $currentPath = Split-Path -Path $currentPath -Parent
}
. ($mockingPath | Select-Object -First 1).FullName

Describe 'Update-AzSynapseFirewallRule' {
    It 'UpdateExpanded' {
        $res = Update-AzSynapseFirewallRule -ResourceGroupName $env.resourceGroup -WorkspaceName $env.testWorkspace1 -RuleName $env.firewallRule2Name -StartIpAddress "111.0.0.0" -EndIpAddress "118.255.255.255"
        { $res.Count } | Should -Be 1
        { $res.StartIpAddress } | Should -Be "111.0.0.0"
        { $res.EndIpAddress } | Should -Be "118.255.255.255"
    }

    It 'UpdateViaIdentityExpanded' {
        $fwr = Get-AzSynapseFirewallRule -ResourceGroupName $env.resourceGroup -WorkspaceName $env.testWorkspace1 -RuleName $env.firewallRule3Name
        $res = Update-AzSynapseFirewallRule -InputObject $fwr -StartIpAddress "121.0.0.0" -EndIpAddress "128.255.255.255"
        { $res.StartIpAddress } | Should -Be "121.0.0.0"
        { $res.EndIpAddress } | Should -Be "128.255.255.255"
    }
}
