#
# Cookbook Name:: opensshmachinerename
# Recipe:: default
#
# Copyright 2015, Taliesin Sisson
#

powershell_script 'Invoke-MkPasswd' do
    guard_interpreter :powershell_script
    code <<-EOH1    
$ErrorActionPreference="Stop"   
$passwdPath = '#{node['opensshmachinerename']['PasswdPath']}'
$mkPasswdPath = '#{node['opensshmachinerename']['MkPasswdPath']}'
&$mkPasswdPath -l -c > $passwdPath

EOH1
    
    only_if <<-EOH2
$ErrorActionPreference="Stop"
$passwdPath = '#{node['opensshmachinerename']['PasswdPath']}'
$mkPasswdPath = '#{node['opensshmachinerename']['MkPasswdPath']}'

$passwdOld = [IO.File]::ReadAllText($passwdPath)
$passwdNew = &$mkPasswdPath -l -c | Out-String

$result = $true
if ($passwdOld -eq $passwdNew){
  $result = $false
}
return $result
EOH2
    action :run
end

powershell_script 'Invoke-MakeGroup' do
    guard_interpreter :powershell_script
    code <<-EOH1    
$ErrorActionPreference="Stop"   
$groupPath = '#{node['opensshmachinerename']['GroupPath']}'
$mkGroupPath = '#{node['opensshmachinerename']['MkGroupPath']}'
&$mkGroupPath -l -c > $groupPath

EOH1
    
    only_if <<-EOH2
$ErrorActionPreference="Stop"
$groupPath = '#{node['opensshmachinerename']['GroupPath']}'
$mkGroupPath = '#{node['opensshmachinerename']['MkGroupPath']}'

$groupOld = [IO.File]::ReadAllText($groupPath)
$groupNew = &$mkGroupPath -l -c | Out-String

$result = $true
if ($groupOld -eq $groupNew){
  $result = $false
}
return $result
EOH2
    action :run
end