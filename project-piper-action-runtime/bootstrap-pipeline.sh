#!/usr/bin/env bash

set -ex

mkdir -p bin
wget -O bin/piper --quiet https://github.com/SAP/jenkins-library/releases/latest/download/piper_master
chmod +x bin/piper
echo "::add-path::${PWD}/bin"
echo "##vso[task.setvariable variable=PATH]${PATH}:${PWD}/bin"

mkdir -p .pipeline

if [ ! -f .pipeline/01_prepareVersion.sh ]; then
    cat << EOF > .pipeline/01_prepareVersion.sh
#!/usr/bin/env bash

set -ex

piper artifactPrepareVersion
EOF
    chmod +x .pipeline/01_prepareVersion.sh
fi

if [ ! -f .pipeline/02_build.sh ]; then
    cat << EOF > .pipeline/02_build.sh
#!/usr/bin/env bash

set -ex

piper mavenBuild
EOF
    chmod +x .pipeline/02_build.sh
fi

if [ ! -f .pipeline/04_staticChecks.sh ]; then
    cat << EOF > .pipeline/04_staticChecks.sh
#!/usr/bin/env bash

set -ex

piper mavenExecuteStaticCodeChecks
EOF
    chmod +x .pipeline/04_staticChecks.sh
fi

