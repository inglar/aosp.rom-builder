#!/bin/bash

# github known_hosts
ssh-keyscan github.com >> ${HOME_DIR}/.ssh/known_hosts
