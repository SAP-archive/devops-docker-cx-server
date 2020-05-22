#!/usr/bin/env pwsh

New-Item -Path bin -ItemType Directory -Force
Invoke-WebRequest https://github.com/SAP/jenkins-library/releases/latest/download/piper_master -OutFile bin/piper
chmod +x bin/piper
Write-Output "::add-path::${PWD}/bin"
Write-Output "##vso[task.setvariable variable=PATH]${PATH}:${PWD}/bin"

$scriptText = @'
#!/usr/bin/env pwsh

function prepare_build() {
    piper artifactPrepareVersion
}
function build() {
    piper mavenBuild
}
function test() {
    echo piper test
}
function check() {
    piper mavenExecuteStaticCodeChecks
}
function security() {
    echo piper security
}
function deploy_artifact() {
    echo piper deploy_artifact
}
function deliver() {
    echo piper deliver
}

if(Test-Path ./.pipeline/ci_extensions.ps1 -PathType Leaf) {
    . ./.pipeline/ci_extensions.ps1
}

switch ($args[0]) {
    'prepare_build' { prepare_build }
    'build' { build }
    'test' { test }
    'check' { check }
    'security' { security }
    'deploy_artifact' { deploy_artifact }
    'deliver' { deliver }
    Default { Write-Output invalid }
}

'@

Set-Content -Path ./.pipeline/ci.ps1 -Value $scriptText
chmod +x ./.pipeline/ci.ps1


