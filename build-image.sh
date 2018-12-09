# Check argument count
if [ $# -ne 3 ]; then
  echo "ARGS: $#" 1>&2
  echo "Error: Require argument=3" 1>&2
  exit 1
fi

cd $(dirname $0)

ARG_DOCKERFILE_DIR=$1
ARG_REPOS_NAME=$2
ARG_REPOS_URL=$3

# AWS Login
$(aws ecr get-login --no-include-email --region ap-northeast-1)

# Build
docker build -t $ARG_REPOS_NAME:latest $ARG_DOCKERFILE_DIR
docker tag $ARG_REPOS_NAME:latest $ARG_REPOS_URL:latest
docker push $ARG_REPOS_URL:latest

exit 0
