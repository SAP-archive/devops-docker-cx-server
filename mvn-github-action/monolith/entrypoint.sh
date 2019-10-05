
echo GITHUB_REF $GITHUB_REF

mvn -Dmaven.repo.local=/github/workspace/maven_local_repo install --update-snapshots --batch-mode \
            --file /github/workspace/pom.xml -Dmaven.test.skip=true

mvn -Dmaven.repo.local=/github/workspace/maven_local_repo test --update-snapshots --batch-mode \
            --file /github/workspace/unit-tests/pom.xml

find /github/workspace
