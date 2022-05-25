# Below is an example of pulling the current version of a node app.

#VERSION is being deprecated by APP_VERSION - no changes necessary - see Makefile
#APP_VERSION=$(shell awk '/version/ {gsub(/[",]/,""); print $$2}' package.json)

# ALWAYS_TIMESTAMP_VERSION=true
# default is false
# app repos: ALWAYS_TIMESTAMP_VERSION should be left alone / set to false
# tooling repos: ALWAYS_TIMESTAMP_VERSION should be set to true
