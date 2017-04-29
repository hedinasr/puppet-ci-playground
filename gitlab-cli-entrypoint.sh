#!/bin/bash

TOKEN="curl -s http://$GITLAB/api/v3/session \
             --data 'login=$GITLAB_USER&password=$GITLAB_PW' \
             | jq '.private_token' | tr -d '"''

GITLAB_API_ENDPOINT=http://$GITLAB/api/v4
GITLAB_API_PRIVATE_TOKEN=$TOKEN

exec gitlab "$@"
