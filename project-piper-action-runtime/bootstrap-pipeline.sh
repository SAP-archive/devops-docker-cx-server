#!/usr/bin/env bash

set -ex

mkdir -p bin
wget -O bin/piper --quiet https://github.com/SAP/jenkins-library/releases/latest/download/piper_master
chmod +x bin/piper
echo "::add-path::${PWD}/bin"
echo "##vso[task.setvariable variable=PATH]${PATH}:${PWD}/bin"

mkdir -p .pipeline

cat << EOF > .pipeline/ci.sh
#!/usr/bin/env bash

set -ex

prepare_build() {
    piper artifactPrepareVersion
}
build() {
    piper mavenBuild
}
test() {
    echo piper test
}
check() {
    piper mavenExecuteStaticCodeChecks
}
security() {
    echo piper security
}
deploy_artifact() {
    echo piper deploy_artifact
}
deliver() {
    echo piper deliver
}

if [ -f .pipeline/ci_extensions.sh ]; then
    . .pipeline/ci_extensions.sh
fi

case \$1 in
    prepare_build) prepare_build;;
    build) build;;
    test) test;;
    check) check;;
    security) security;;
    deploy_artifact) deploy_artifact;;
    deliver) deliver;;
    *) echo Invalid command \$1;;
esac

EOF

chmod +x .pipeline/ci.sh
