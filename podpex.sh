#!/bin/bash
git submodule init
git submodule update
podman build ./podman -t apex
podman run -p 8080:8080 -v ./podman/static-apex:/apex:Z apex
