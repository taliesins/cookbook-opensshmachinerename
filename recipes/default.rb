#
# Cookbook Name:: opensshmachinerename
# Recipe:: default
#
# Copyright 2015, Taliesin Sisson
#

powershell_script 'Update-Passwd' do
    guard_interpreter :powershell_script
    code <<-EOH1    
$ErrorActionPreference="Stop"   
$passwdPath = '#{node['opensshmachinerename']['PasswdPath']}'
$mkPasswdPath = '#{node['opensshmachinerename']['MkPasswdPath']}'
&$mkPasswdPath -l > $passwdPath

EOH1
    
    only_if <<-EOH2
$ErrorActionPreference="Stop"
$passwdPath = '#{node['opensshmachinerename']['PasswdPath']}'
$mkPasswdPath = '#{node['opensshmachinerename']['MkPasswdPath']}'

$passwdOld = [IO.File]::ReadAllText($passwdPath)
$passwdNew = &$mkPasswdPath -l  | Out-String

$result = $true
if ($passwdOld -eq $passwdNew){
  $result = $false
}
return $result
EOH2
    action :run
end