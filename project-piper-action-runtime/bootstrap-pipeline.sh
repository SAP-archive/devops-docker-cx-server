#!/usr/bin/env bash

set -ex

mkdir -p bin
wget -O bin/piper --quiet https://github.com/SAP/jenkins-library/releases/latest/download/piper_master
chmod +x bin/piper
echo "::add-path::${PWD}/bin"
echo "##vso[task.setvariable variable=PATH]${PATH}:${PWD}/bin"

mkdir -p .pipeline

if [ ! -f .pipeline/ci.sh ]; then
    cat << EOF > .pipeline/ci.sh
#!/usr/bin/env bash

set -ex

build() {
    echo piper build
}
test() {
    echo piper test
}
check() {
    echo piper check
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
    build) echo build;;
    test) echo test;;
    check) echo check;;
    security) echo security;;
    deploy_artifact) echo deploy_artifact;;
    deliver) echo deliver;;
    *) echo foobar;;
esac


EOF
    chmod +x .pipeline/ci.sh
fi
