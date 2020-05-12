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


if [ ! -f .pipeline/03_tests.sh ]; then
    cat << EOF > .pipeline/03_tests.sh
#!/usr/bin/env bash

set -ex

piper mavenExecute --goals=verify

EOF
    chmod +x .pipeline/03_tests.sh
fi


if [ ! -f .pipeline/04_staticChecks.sh ]; then
    cat << EOF > .pipeline/04_staticChecks.sh
#!/usr/bin/env bash

set -ex

piper mavenExecuteStaticCodeChecks
EOF
    chmod +x .pipeline/04_staticChecks.sh
fi

if [ ! -f .pipeline/ci.sh ]; then
    cat << EOF > .pipeline/ci.sh
#!/usr/bin/env bash

set -ex

# Pipeline script for running locally as an alternative to act


. .pipeline/01_prepareVersion.sh

. .pipeline/02_build.sh

. .pipeline/04_staticChecks.sh

EOF
    chmod +x .pipeline/ci.sh
fi

