#!/bin/bash

# copy local manifests
if [ -d ${HOME_DIR}/local_manifests ]; then
  mkdir -p ${HOME_DIR}/src/.repo/local_manifests/ \
    && rm -rf ${HOME_DIR}/src/.repo/local_manifests/* \
    && cp ${HOME_DIR}/local_manifests/*.xml ${HOME_DIR}/src/.repo/local_manifests/
fi
