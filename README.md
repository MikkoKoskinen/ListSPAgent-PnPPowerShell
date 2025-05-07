# ListSPAgent-PnPPowerShell
Use PnP PowerShell to list SharePoint Agents (.agent files).
The script uses PnP PowerShell to fetch the information of each SharePoint Agent created on SharePoint sites and libraries.
This script can list only the declarative agents created with Copilot Studio Agent Builder straight from the SharePoint UI. Other agent types can be listed with other administrative tools.

# PnP PowerShell Script
The script is found from the List-SP-Agents.ps1 file: https://github.com/MikkoKoskinen/ListSPAgent-PnPPowerShell/blob/main/List-SP-Agents.ps1
 
OBS! You need to install the PnP PowerShell module before you can use the script: https://pnp.github.io/powershell/articles/
The script needs to be run as non interactive application connection so that it will have a full access to all the sites.
This can be done as based in the instructions:https://pnp.github.io/powershell/articles/registerapplication.html#setting-up-access-to-your-own-entra-id-app-for-app-only-access
Make also sure that the Entra app used in the connection has access to read all SharePoint sites: https://pnp.github.io/powershell/articles/determinepermissions.html

Note: The script is tested only for a relatively small SharePoint and agent environment. You should refactor the code for large enterprise use cases to handle large (tens of thousands) sites and agent files.

OUTPUT
Saves the app details to a CSV file.

PARAMETERS
OBS! Remember to update the following parameters in the first section of the script.

$folderPath = The path to the folder where the CVS list is saved (for example, C:\Temp\Exports)
$PnPClientId = The ID of the Entra application used while connecting to SharePoint (for example, xxxxxxxx-b5d4-4f79-9947-88bd96e3907f)
$PnPClienCertPath = link and path of the certification file (for example, C:\Temp\PnP PowerShell Client App.pfx)
$OrgTenantName = tenant name of the organisation (for example, mysptenant)

More information about SharePoint agents: https://adoption.microsoft.com/en-us/sharepoint-agents/

