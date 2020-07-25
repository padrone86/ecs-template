#!/bin/bash -eu
#
# deploy_frontend.sh

readonly PRODUCT="ecs-template"
readonly WORKSPACE="default"
readonly PROFILE="private"
readonly BUCKET_NAME="${PRODUCT}-${WORKSPACE}-frontend"
readonly GIT_ROOT_DIR=$(git rev-parse --show-toplevel)

cd "${GIT_ROOT_DIR}/frontend"

npm run build
aws s3 cp dist/ "s3://${BUCKET_NAME}" --recursive --profile "${PROFILE}"
