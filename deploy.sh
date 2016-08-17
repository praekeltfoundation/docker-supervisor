#!/usr/bin/env bash
set -e

function usage() {
  echo "Usage: $0 DOCKER_TAG [--latest]"
  echo "  IMAGE_TAG : the Docker image tag for the Supervisor image to deploy"
  echo "  --latest  : option to tag the image with the 'latest' and version tag"
}

DOCKER_TAG="$1"
shift || { usage >&2; exit 1; }

# Parse the version of Supervisor from the requirements file
SUPERVISOR_VERSION="$(sed -E 's/\s*supervisor\s*==\s*([^\s\;]+).*/\1/' requirements.txt)"

TAGS=("$SUPERVISOR_VERSION-${DOCKER_TAG##*:}")
if [[ "$1" == "--latest" ]]; then
  TAGS+=("$SUPERVISOR_VERSION" "latest")
fi

# Push the current tag
docker push "$DOCKER_TAG"

# Tag the other tags and push them
IMAGE_NAME="${DOCKER_TAG%%:*}"
for tag in "${TAGS[@]}"; do
  image_tag="$IMAGE_NAME:$tag"
  docker tag "$DOCKER_TAG" "$image_tag"
  docker push "$image_tag"
done
