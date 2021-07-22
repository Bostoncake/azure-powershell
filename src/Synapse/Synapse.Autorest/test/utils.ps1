function RandomString([bool]$allChars, [int32]$len) {
    if ($allChars) {
        return -join ((33..126) | Get-Random -Count $len | % {[char]$_})
    } else {
        return -join ((48..57) + (97..122) | Get-Random -Count $len | % {[char]$_})
    }
}
$env = @{}
function setupEnv() {

    Write-Host -ForegroundColor Yellow "WARNING: Need to use released Az.Synapse module. Please check if Az.Synapse(0.1.0 or Greater) installed."
    Import-Module -Name Az.Synapse
    Write-Host "asdasd"

    # Preload subscriptionId and tenant from context, which will be used in test
    # as default. You could change them if needed.
    $env.SubscriptionId = (Get-AzContext).Subscription.Id
    $env.Tenant = (Get-AzContext).Tenant.Id
    
    Write-Host -ForegroundColor Green "Generating random names for testing..."
    # Generate some random strings for use in the test.
    $rstr1 = RandomString -allChars $false -len 6
    $rstr2 = RandomString -allChars $false -len 6
    $rstr3 = RandomString -allChars $false -len 6
    $rstr4 = RandomString -allChars $false -len 6
    $rstr5 = RandomString -allChars $false -len 6
    $rstr6 = RandomString -allChars $false -len 6
    $rstr7 = RandomString -allChars $false -len 6
    $rstr8 = RandomString -allChars $false -len 6
    $rstr9 = RandomString -allChars $false -len 6
    # Add ramdom strings to $env as will be used in test directly
    $rstr10 = RandomString -allChars $false -len 6
    $rstr11 = RandomString -allChars $false -len 6
    $rstr12 = RandomString -allChars $false -len 6
    $null = $env.Add("rstr10", $rstr10)
    $null = $env.Add("rstr11", $rstr11)
    $null = $env.Add("rstr12", $rstr12)

    # Create the test group
    Write-Host -ForegroundColor Green "Creating test group..."
    $resourceGroup = "synapse-rg-" + $rstr1
    $null = $env.Add("resourceGroup", $resourceGroup)
    New-AzResourceGroup -Name $resourceGroup -Location eastasia
    Write-Host -ForegroundColor Green "Test group create completed."

    # Create Synapse workspaces for test
    Write-Host -ForegroundColor Green "Creating Synapse workspace for test..."
    $testWorkspace1 = "workspace" + $rstr2
    $testStorageAccount = "storageAccount" + $rstr3
    $testFileSystem = "fileSystem" + $rstr4
    $passwordString = "Password1!" + $rstr5
    $password = ConvertTo-SecureString $passwordString -AsPlainText -Force
    $loginUser = "user" + $rstr6
    $creds = New-Object System.Management.Automation.PSCredential ($loginUser, $password)
    New-AzSynapseWorkspace -Name $testWorkspace1 -ResourceGroupName $resourceGroup -Location eastasia -DefaultDataLakeStorageAccountName $testStorageAccount -DefaultDataLakeStorageFilesystem $testFileSystem -SqlAdministratorLoginCredential $creds
    $null = $env.Add("testWorkspace1", $testWorkspace1)
    Write-Host -ForegroundColor Green "Workspace create completed."

    # Create firewall rules for test
    Write-Host -ForegroundColor Green "Creating firewall rules for test..."
    $testFirewallRule1 = "firewallrule" + $rstr7
    $testFirewallRule2 = "firewallrule" + $rstr8
    $testFirewallRule3 = "firewallrule" + $rstr9
    $firewallRule1Start = "100.0.0.0"
    $firewallRule1End = "109.255.255.255"
    $firewallRule2Start = "110.0.0.0"
    $firewallRule2End = "119.255.255.255"
    $firewallRule3Start = "120.0.0.0"
    $firewallRule3End = "129.255.255.255"
    New-AzSynapseFirewallRule -WorkspaceName $testWorkspace1 -RuleName $testFirewallRule1 -ResourceGroupName $resourceGroup -StartIpAddress $firewallRule1Start -EndIpAddress $firewallRule1End
    New-AzSynapseFirewallRule -WorkspaceName $testWorkspace1 -RuleName $testFirewallRule2 -ResourceGroupName $resourceGroup -StartIpAddress $firewallRule2Start -EndIpAddress $firewallRule2End
    New-AzSynapseFirewallRule -WorkspaceName $testWorkspace1 -RuleName $testFirewallRule3 -ResourceGroupName $resourceGroup -StartIpAddress $firewallRule3Start -EndIpAddress $firewallRule3End
    $null = $env.Add("firewallRule1Name", $testFirewallRule1)
    $null = $env.Add("firewallRule1Start", $firewallRule1Start)
    $null = $env.Add("firewallRule1End", $firewallRule1End)
    $null = $env.Add("firewallRule2Name", $testFirewallRule2)
    $null = $env.Add("firewallRule2Start", $firewallRule2Start)
    $null = $env.Add("firewallRule2End", $firewallRule2End)
    $null = $env.Add("firewallRule3Name", $testFirewallRule3)
    $null = $env.Add("firewallRule3Start", $firewallRule3Start)
    $null = $env.Add("firewallRule3End", $firewallRule3End)
    Write-Host -ForegroundColor Green "Firewall rules create completed."

    # For any resources you created for test, you should add it to $env here.
    $envFile = 'env.json'
    if ($TestMode -eq 'live') {
        $envFile = 'localEnv.json'
    }
    set-content -Path (Join-Path $PSScriptRoot $envFile) -Value (ConvertTo-Json $env)
}
function cleanupEnv() {
    # Clean resources you create for testing
    # Removing resource group will clean all the resources created for testing
    Remove-AzResourceGroup -Name $env.resourceGroup
}

