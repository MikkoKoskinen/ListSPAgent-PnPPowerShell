###################################################
# List SharePoint Agents
#
# DESCRIPTION
# The script uses PnP PowerShell to fetch the information of each SharePoint Agent created on SharePoint sites and libraries.
# This script can list only the declarative agents created with Copilot Studio Agent Builder straight from the SharePoint UI. Other agent types can be listed with other administrative tools.
# 
# OBS! You need to install the PnP PowerShell module before you can use the script: https://pnp.github.io/powershell/articles/
# The application used in the PnP connection needs to give the user access to read all SharePoint sites: https://pnp.github.io/powershell/articles/determinepermissions.html
#
# Note: The script is tested only for a relatively small SharePoint and agent environment. You should refactor the code for large enterprise use cases to handle large (tens of thousands) sites and agent files.
#
# OUTPUT
# Saves the app details to a CSV file.
#
# PARAMETERS
# OBS! Remember to update the following parameters in the first section of the script.
#
# PnPClientId = The ID of the Entra application used while connecting to SharePoint
# $folderPath = The path to the folder where the CVS list is saved (for example, C:\Temp\Exports)
#
# More information about SharePoint agents: https://adoption.microsoft.com/en-us/sharepoint-agents/

# PARAMETES to Update
$folderPath = '[FOLDER_PATH]'
$PnPClientId = "[CLIENT_ID]"

# Other internal parameters
$SPAgentsList = @()

# Open Connections
Write-host ('Opening the SP connection.')
$spConn = Connect-PnPOnline sulavalabs.sharepoint.com -Interactive -ClientId $PnPClientId -ReturnConnection

#Get the list of found agents
Write-host (' ')
Write-host ('Search the SharePoint Agents')
$SPAgents = Submit-PnPSearchQuery -Query "filetype:agent" -TrimDuplicates:$false -All -Connection $spConn

Write-host ('...found ' + $SPAgents.RowCount + ' agents.')

#Loop through each agent and save the details to array
Write-host (' ')
Write-host ('Loop and save agent details.')

foreach ($agent in $SPAgents.ResultRows) {
    Write-host ('...Agent Title: ' + $agent.Title + " - Site: " + $agent.SiteName)
    
    #Add agent details to row
    $row = @{
        Title           = $agent.Title
        SPWeb           = $agent.SPWebUrl
        Author          = $agent.Author
        Created         = ([DateTime]$agent.Write).ToString("dd.MM.yyyy")
        Modified        = ([DateTime]$agent.LastModifiedTime).ToString("dd.MM.yyyy")
        OriginalPath    = $agent.OriginalPath
        ListId          = $agent.ListId
        ViewsLifeTime   = $agent.ViewsLifeTime
        ViewsRecent     = $agent.ViewsRecent
    }
    
    $SPAgentsList += $(new-object psobject -Property $row)
}

#Save the RAW reporting details
$SPAgentsList | Export-Csv -Path ($folderPath + '\SPAgentsList.csv') -Delimiter ';' -NoTypeInformation -Encoding UTF8
