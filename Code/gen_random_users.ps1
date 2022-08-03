# --- AlrikRr : Generate JSON Base file

# Mandatory Params :
# - OutJSONFile : Name of output json file
# Going :
# - Takes list of lastnames, firstnames, groups and passwords
# - Get random of everything and create a group and a user list
# - Avoid duplicates
# - Output as JSON format for ad_users.ps1 script

param([Parameter(Mandatory=$true)] $OutJSONFile)

$group_names = [System.Collections.ArrayList](Get-Content "data/groups.txt")
$first_names = [System.Collections.ArrayList](Get-Content "data/firstnames.txt")
$last_names = [System.Collections.ArrayList](Get-Content "data/lastnames.txt")
$password_list = [System.Collections.ArrayList](Get-Content "data/rockyou.txt")

# Store the list of groups and users randomly generated
$group_list = @()
$users_list = @()

# Max number of Groups and Users
$max_group = 10
$max_users = 100

# Generate a list of groups randomly generated using max number of group
for ($i = 0; $i -lt $max_group ; $i++){
    $Random_Group = (Get-Random -InputObject $group_names).Trim()
    $new_group = @{
        "name"="$Random_Group"
    }
    $group_list += $new_group
    # Clean list to avoid duplicate
    $group_names.Remove($Random_Group)
}

# Generate a list of users randomly generated using max number of users
for ($i = 0; $i -lt $max_users ; $i++){

    $Random_Password = (Get-Random -InputObject $password_list).Trim()
    $Random_Firstname = (Get-Random -InputObject $first_names).Trim()
    $Random_Lastname = (Get-Random -InputObject $last_names).Trim()
    $Random_Group = (Get-Random -InputObject $group_list.name)
    $SamAccountName = $Random_Firstname.ToLower() + "." + $Random_Lastname.ToLower()

    $new_user = @{
        "first_name"="$Random_Firstname"
        "last_name"="$Random_Lastname"
        "password"="$Random_Password"
        "samaccount"="$SamAccountName"
        "groups" = @($Random_Group)
    }

    $users_list += $new_user

    # Clean Lists to avoid duplicates
    $password_list.Remove($Random_Password)
    $first_names.Remove($Random_Firstname)
    $last_names.Remove($Random_Lastname)
}

@{
    "domain"="nerv.com"
    "groups"=$group_list
    "users"=$users_list
} | ConvertTo-Json | Out-File $OutJSONFile