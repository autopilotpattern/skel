# Autopilot Pattern Blueprint for ...

Explain how to launch on local Docker daemon and be sure to include namespace
via `-p`. Something along the lines of:

To launch redis locally (on Docker for Mac as an example):

```bash
$ docker-compose -p PRJ_NAME up -d
```

To scale it:

```bash
$ docker-compose -p PRJ_NAME scale PRJ_NAME=3
```
