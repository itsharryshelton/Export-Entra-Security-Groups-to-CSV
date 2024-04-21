# Export-Entra-Security-Groups-to-CSV
TLDR - Script to Export Entra ID/Azure AD Security Groups to CSV, including members within the group

Script will connect you to Azure AD (or now technically Entra ID) via PowerShell, and export Entra Security groups to your CSV, with a members list. 
**Please not that at the moment this script only supports Entra Security Groups.**

There are two versions of this script, only use one main file:

**Main Script** = _You already have AzureAD Module installed or do not want it to check_

**Install Module + Main Script** = _You do not/not know if you have AzureAD module installed, you may require PowerShell to be ran in Admin Mode to execute this script. This script will also set your execution policy to unrestricted for your current user._

**=====================================================================================**

The export will be put here: C:\temp
The code will check if this folder exists before making it, if you have permission issues with it exporting make sure you're allowed to create folders in the C Drive, otherwise edit the $tempFolderPath where you want it export to instead.
