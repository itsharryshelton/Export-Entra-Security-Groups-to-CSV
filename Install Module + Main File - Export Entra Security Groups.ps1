Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
#Check if you have AzureAD module installed
if (-not (Get-Module -Name AzureAD -ListAvailable)) {
    Write-Host "AzureAD module is not installed. Installing now..."
    try {
        # Install AzureAD module with execution policy set to Unrestricted
        Install-Module -Name AzureAD -Force -Scope CurrentUser -AllowClobber -Repository PSGallery -Verbose
    } catch {
        Write-Error "Failed to install AzureAD module."
        exit
    }
}

Write-Host "Script for exporting  security groups from Entra ID - Written by Harry Shelton"

#Connects you to AzureAD/Entra ID
Import-Module -Name AzureAD
Connect-AzureAD

# Pulling all the groups
$groups = Get-AzureADGroup -All $true | Where-Object { $_.SecurityEnabled -eq $true }

# Starts array otherwise group member fails to pull correctly
$groupDetails = @()

# loop for each group
foreach ($group in $groups) {
    $groupDetail = New-Object PSObject -Property @{
        "Group Name" = $group.DisplayName
        "Group ID" = $group.ObjectId
        "Members" = @()
    }
    
    # Get members and assign to variable
    $members = Get-AzureADGroupMember -ObjectId $group.ObjectId | Where-Object { $_.ObjectType -eq "User" }
    
    # Add members to the group details
    $memberNames = $members.UserPrincipalName -join ", "
    $groupDetail.Members = $memberNames
    
    # Add group details to the array
    $groupDetails += $groupDetail
}

#**********************************************************
#Exporting to CSV Section of Code:

$tempFolderPath = "C:\temp"

#Error checking
if (-not (Test-Path -Path $tempFolderPath)) {
    New-Item -Path $tempFolderPath -ItemType Directory
}


$groupDetails | Export-Csv -Path "$tempFolderPath\security_groups_members.csv" -NoTypeInformation
#**********************************************************