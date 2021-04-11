if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    write-Warning "This setup needs admin permissions. Please run this file as admin."     
    break
 }

Install-Module -Name ConfigFile
Import-ConfigFile -Ini -ConfigFilePath "project_create.ini" #Config file must be in the INI format
$dotnetVersions = (dir (Get-Command dotnet).Path.Replace('dotnet.exe', 'sdk')).Name
if (!($dotnetVersions -like '5.*')) {
    Write-Host "[.NET] Installing current .net core LTS version..."
    ./dotnet-install.ps1
}
else {
    Write-Host "[.NET] .NET Core version $($dotnetVersions -like '5.*' | Select-Object -Last 1 )  already installed"
}
if (Get-Command node -errorAction SilentlyContinue) {
    $current_version = (node -v)
}
 if(Get-Command git -ErrorAction SilentlyContinue) {
     $git_version = (git --version)
 }
 if($git_version) {
    write-host "[GIT] Git $git_version already installed"   
 }else {
    Write-Host "[GIT] Installing Git..."
    wget $git_link  -OutFile "gitinstall.exe"
    ./gitinstall.exe
 }
if ($current_version) {
    write-host "[NODE] nodejs $current_version already installed"
}
else {
    Write-Host "[NODE] Installing Node.js with npm..."
    wget $node_link -OutFile "nodeInstall.msi"
    ./nodeInstall.msi
}
npm install -g yo
npm install -g pnpm
npm install -g generator-svalter
md -Name "sln"
cd .\sln
dotnet new sln -n "H3Dex"
cd ..
md -Name "src"
md -Name "packages"

cd .\src
dotnet new webapi -n "Mateuszr.H3Dex.webapi"
md -Name "Mateuszr.H3Dex.UI"


