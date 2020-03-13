# Notes on running CX Server in Production

Please be aware that running a Jenkins in production securly is not a trivial task.

Some recommendations:

The `latest` tag of CX Server Docker images are rebuilt on a regular basis.
To benefit from updated Jenkins core and plugin versions, you should stop, remove and restart your CX Server instance on a regular basis.
Part of this procedure should be to take backups (see `backup` and `restore` commands of `cx-server`).
The commands perform an update of CX Server are:

```
./cx-server stop
./cx-server remove
./cx-server start
```

If you use released versions of the CX Server, look for new releases on https://github.com/SAP/devops-docker-cx-server/releases

In addition, we recomment to [read about "Securing Jenkins"](https://jenkins.io/doc/book/system-administration/security/) in the Jenkins manual.
