# Check argument count
if [ $# -ne 4 ]; then
  echo "ARGS: $#" 1>&2
  echo "Error: Require argument=4" 1>&2
  exit 1
fi

cd $(dirname $0)

ARG_PROFILE=$1
ARG_DOCKERFILE_DIR=$2
ARG_REPOS_NAME=$3
ARG_REPOS_URL=$4

# AWS Login
aws ecr get-login-password --region ap-northeast-1 --profile ${ARG_PROFILE} | docker login --username AWS --password-stdin 545009660400.dkr.ecr.ap-northeast-1.amazonaws.com

# Build
docker build -t $ARG_REPOS_NAME:latest $ARG_DOCKERFILE_DIR
docker tag $ARG_REPOS_NAME:latest $ARG_REPOS_URL:latest
docker push $ARG_REPOS_URL:latest

exit 0
