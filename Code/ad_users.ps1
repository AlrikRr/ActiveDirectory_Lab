# --- AlrikRr : Generate AD Users Script

# Mandatory Params :
# - JsonFile : PATH to the JSON file used to generate users
# Going :
# - Take JSON file as param
# - Change password policy of Domain 
# - Create new groups
# - Create new users
# - Add users to groups


param(
	[Parameter(Mandatory=$true)] $JsonFile,
	[switch]$Revert	
)

function Create-NewGroups(){
		param([Parameter(Mandatory=$true)] $groupObject)

		$name = $groupObject.name
		try{
			New-ADGroup -Name $name -GroupScope Global 
		}catch [Microsoft.ActiveDirectory.Management.Commands.NewADGroup]{
			Write-Warning "[!] Create New group $name : Group Already Exist"
		}
}

function Create-NewADUsers(){

	param([Parameter(Mandatory=$true)] $userObject)

	#Get First & Last name from JSON user
	$First = $userObject.first_name
	$Last = $userObject.last_name
	$Pass = $userObject.password
	$Sam = $userObject.samaccount
	$principalName = $userObject.samaccount

	# Create the AD User Object 
	try{
		New-ADUser -Name "$First $Last" -GivenName $First -Surname $Last -SamAccountName $Sam -UserPrincipalName $principalName@$Global:Domain -AccountPassword (ConvertTo-SecureString $Pass -AsPlainText -Force) -PassThru | Enable-ADAccount 
	}catch [Microsoft.ActiveDirectory.Management.Commands.NewADUser]{
		Write-Warning "[!] Create New User $principalName : User Already Exist"
	}

	# Add User to Groups
	foreach ($group_name in $userObject.groups){

		# Check if Group exist or not before adding the user into it
		try 
		{
				Get-ADGroup -Identity $group_name
				Add-ADGroupMember -Identity $group_name -Members $principalName
		}
		catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException] 
		{
				Write-Warning "[!] Add $principalName to $group_name : Group Does not exist"
		}
	
	}

}

function Remove-PasswordComplexity(){
    secedit /export /cfg C:\Windows\Tasks\secpol.cfg
    (Get-Content C:\Windows\Tasks\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0").replace("MinimumPasswordLength = 7", "MinimumPasswordLength = 1") | Out-File C:\Windows\Tasks\secpol.cfg
    secedit /configure /db c:\windows\security\local.sdb /cfg C:\Windows\Tasks\secpol.cfg /areas SECURITYPOLICY
    rm -force C:\Windows\Tasks\secpol.cfg -confirm:$false
}

####### REVERT Functions

function Revert-PasswordComplexity(){
    secedit /export /cfg C:\Windows\Tasks\secpol.cfg
    (Get-Content C:\Windows\Tasks\secpol.cfg).replace("PasswordComplexity = 0", "PasswordComplexity = 1").replace("MinimumPasswordLength = 1", "MinimumPasswordLength = 7") | Out-File C:\Windows\Tasks\secpol.cfg
    secedit /configure /db c:\windows\security\local.sdb /cfg C:\Windows\Tasks\secpol.cfg /areas SECURITYPOLICY
    rm -force C:\Windows\Tasks\secpol.cfg -confirm:$false
}

function Remove-Groups(){
	param([Parameter(Mandatory=$true)] $groupObject)
	$name = $groupObject.name
	Remove-ADGroup -Confirm:$false -Identity $name  
}

function Remove-Users(){
	param([Parameter(Mandatory=$true)] $userObject)
	$sam = $userObject.samaccount
	Remove-ADUser -Confirm:$false -Identity $sam  
}



#Get and convert the content of the json file into a JSON variable
$json_file =  (Get-Content $JsonFile | ConvertFrom-JSON )
$Global:Domain = $json_file.domain


if( -not $Revert){

	# Remove Complexity on Passwords
	Remove-PasswordComplexity
	
	#Loop - Create Groups 
	foreach ($group in $json_file.groups){
		Create-NewGroups $group
	}

	#Loop - Create Users 
	foreach ($user in $json_file.users){
		Create-NewADUsers $user
	}
}else {
	#Revert the changes on the Password Policy
	Revert-PasswordComplexity
	#Loop - Remove Users 
	foreach ($user in $json_file.users){
		Remove-Users $user
	}

	#Loop - Remove Groups 
	foreach ($group in $json_file.groups){
		Remove-Groups $group
	}
}


