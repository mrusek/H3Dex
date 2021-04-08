Install-Module -Name ConfigFile
Import-ConfigFile -Ini -ConfigFilePath "project_create.config" #Config file must be in the INI format
md -Name "sln"
cd .\sln
dotnet new sln -n "H3Dex"
cd ..
md -Name "src"
md -Name "packages"

cd .\src
dotnet new webapi -n "Mateuszr.H3Dex.webapi"

