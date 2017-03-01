
$desired_node_version='v6'
$desired_npm_version='3'
$desired_yo_version='1'

function installChoclatey() {
    try {
        Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression
    } catch {
        Write-Error 'Failed to install chocolatey'
    }
}

function installNode() {
    Write-Error 'Not implimented yet'      
}

function installNpm() {
    Write-Error 'Not implimented yet'      
}

function installYo() {
    try {
        npm install -g yo
    } catch {
        Write-Error 'Not implimented yet'
    }
}

if (!$IsWindows) {
    Write-Output 'Not using windows, invoking shell script'
    Set-Location $PSScriptRoot
    /bin/bash ./unix-setup.sh
} else {
    Write-Error 'Not implimented yet'   
}

$err = false
$node_version = ''
try {
    $node_version = Invoke-Expression 'node --version'
} catch {
    $err = true
}

if ($err) {
    Write-Output 'Node not installed'
    installNode
} elseif ($node_version.Split('.')[0] -ne $desired_node_version) {
    Write-Output 'Current node version is not desired node version'
    installNode
} else {
    Write-Output 'Node already installed'
}

$err = false
$npm_version = ''
try {
    $node_version = Invoke-Expression 'npm --version'
} catch {
    $err = true
}

if ($err) {
    Write-Output 'npm not installed'
    installNpm
} elseif ($node_version.Split('.')[0] -ne $desired_npm_version) {
    Write-Output 'Current npm version is not desired npm version'
    installNpm
} else {
    Write-Output 'npm already installed'
}

$err = false
$yo_version = ''
try {
    $node_version = Invoke-Expression 'yo --version'
} catch {
    $err = true
}

if ($err) {
    Write-Output 'Yo not installed'
    installYo
} elseif ($node_version.Split('.')[0] -ne $desired_yo_version) {
    Write-Output 'Current yo version is not desired yo version'
    installYo
} else {
    Write-Output 'Yo already installed'
}