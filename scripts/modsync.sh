#!/bin/bash

set -e

K3S_REPO="${K3S_REPO:-k3s-io/k3s}"

# Match a golang pesudo-version string, for example: v1.31.2-0.20241011135109-46cfd2cf55d3
# When a pseudo-version is matched only the commit hash is used, otherwise use the corresponding tag with +k3s1 appended
TAG_OR_COMMIT=$(echo "$1" | awk 'match($0, /\.[[:digit:]]{14}-([[:alnum:]]{12})/, capture) {print capture[1]}')
if [[ -z "${TAG_OR_COMMIT}" ]]; then
  TAG_OR_COMMIT=${1/-build*/+k3s1}
fi
echo "Updating go.mod replacements from ${K3S_REPO} at tag ${TAG_OR_COMMIT}"

URL="https://raw.githubusercontent.com/${K3S_REPO}/${TAG_OR_COMMIT}/go.mod"
echo "Using go.mod from ${URL}"
K3S_GO_MOD=$(curl -qsfL "${URL}")

if [[ -z "${K3S_GO_MOD}" ]]; then
  echo "Failed to get go.mod from ${URL}"
  exit 1
fi

# ensure k8s.io replacements
while read OLDPATH NEWPATH VERSION; do
  (set -x; go mod edit --replace="${OLDPATH}=${NEWPATH}@${VERSION}")
done <<< $(go mod edit --json /dev/stdin <<<${K3S_GO_MOD} | jq -r '.Replace[] | select(.Old.Path | contains("k8s.io")) | .Old.Path + " " + .New.Path + " " + .New.Version')

# update replacements
while read OLDPATH NEWPATH VERSION; do
  REPLACEMENT=$(go mod edit --json /dev/stdin <<<${K3S_GO_MOD} | jq -r --arg OLDPATH "${OLDPATH}" '.Replace[] | select(.Old.Path==$OLDPATH) | .New.Version')
  K3S_PATH=$(go mod edit --json /dev/stdin <<<${K3S_GO_MOD} | jq -r --arg OLDPATH "${OLDPATH}" '.Replace[] | select(.Old.Path==$OLDPATH) | .New.Path')
  if [ -n "${K3S_PATH}" ]; then
    NEWPATH="${K3S_PATH}"
  fi
  echo "Checking for updates to ${OLDPATH} ${VERSION} -> ${REPLACEMENT}"
  if [ -n "${REPLACEMENT}" ] && [ "${REPLACEMENT}" != "null" ] && grep -vqF github.com/k3s-io/k3s <<<${NEWPATH} && semver-cli greater ${REPLACEMENT} ${VERSION} ; then
    (set -x; go mod edit --replace="${OLDPATH}=${NEWPATH}@${REPLACEMENT}")
  elif [ -z "${REPLACEMENT}" ] ; then
    (set -x; go mod edit --dropreplace="${OLDPATH}")
  fi
done <<< $(go mod edit --json | jq -r '(.Replace[] | .Old.Path + " " + .New.Path + " " + .New.Version)')

(set -x; go mod edit --dropreplace="github.com/k3s-io/k3s" --require="github.com/k3s-io/k3s@${TAG_OR_COMMIT}")

go mod tidy
