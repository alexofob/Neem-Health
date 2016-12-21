#!/bin/bash

elm package install -y && \
  yarn && \
  bower install && \
  yarn run start
