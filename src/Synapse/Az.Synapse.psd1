@{
  GUID = '7a3c74c9-3c2e-4b1f-92ff-58da551a3d18'
  RootModule = './Az.Synapse.psm1'
  ModuleVersion = '0.1.0'
  CompatiblePSEditions = 'Core', 'Desktop'
  Author = 'Microsoft Corporation'
  CompanyName = 'Microsoft Corporation'
  Copyright = 'Microsoft Corporation. All rights reserved.'
  Description = 'Microsoft Azure PowerShell: Synapse cmdlets'
  PowerShellVersion = '5.1'
  DotNetFrameworkVersion = '4.7.2'
  RequiredAssemblies = './bin/Az.Synapse.private.dll'
  FormatsToProcess = './Az.Synapse.format.ps1xml'
  FunctionsToExport = 'Get-AzSynapseFirewallRule', 'New-AzSynapseFirewallRule', 'Remove-AzSynapseFirewallRule', 'Update-AzSynapseFirewallRule', '*'
  AliasesToExport = '*'
  PrivateData = @{
    PSData = @{
      Tags = 'Azure', 'ResourceManager', 'ARM', 'PSModule', 'Synapse'
      LicenseUri = 'https://aka.ms/azps-license'
      ProjectUri = 'https://github.com/Azure/azure-powershell'
      ReleaseNotes = ''
    }
  }
}
