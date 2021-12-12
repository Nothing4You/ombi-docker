# simple container that can be used without launching the container as root

`latest` tag is based on the `master` branch of this repository.
Versions are tagged matching the versions tagged in the upstream repository at https://github.com/Ombi-app/Ombi.
Git tags match docker tags.

Images can be pulled from `ghcr.io/nothing4you/ombi-docker/ombi`.

Configuration storage needs to be mounted at `/storage` and chowned to the user that the container is started as.
No privilege drop implemented as this is designed to not be lauched as root.
You will still need to define the user and group to run the container with as it defaults to root.
