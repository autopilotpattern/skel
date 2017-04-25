# Skeleton structure for an Autopilot Pattern blueprint

1. Update PRJ_NAME in `Makefile` to be a meaningful name, lile `redis`...
2. Update `Dockerfile` to source from the correct base image, install the
   correct dependencies, and launch ContainerPilot with the proper primary
   executable
3. Add application configuration files to `etc`, and update
   `etc/containerpilot.json`
4. Update the contents of `examples/compose` and `examples/triton` with
   meaningul and documented examples. Be sure to maintain the dynamic image
   version format as this will be important for CI (Jenkins).
5. Install `autopilotpattern/testing` as a submodule in the `test` directory:
   `git submodule add git@github.com:autopilotpattern/testing.git test/testing`
6. Update `test/tests.py` to perform meaningful tests

If all of the above was done correctly the following should work:

```
eval "$(triton env)"
make build push pull test
```

This will build the application docker image as well as the test runner docker
image, send appropriately tagged images to docker hub (based on your local
branch name), pull them onto Triton, then run the test runner image locally
targeting the Triton docker remote api! 
