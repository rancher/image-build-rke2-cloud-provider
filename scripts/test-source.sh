#!/bin/bash

set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
while IFS=' ' read -r minor commit; do
  result=$(bash "${ROOT}/scripts/source.sh" "${minor}")
  [[ "${result}" == "${minor} ${commit}" ]]
  [[ "${commit}" =~ ^[0-9a-f]{40}$ ]]

  for revision in 1 2 12; do
    tag="${minor}-r${revision}-build20200101"
    [[ "$(bash "${ROOT}/scripts/source.sh" "${tag}")" == "${minor} ${commit}" ]]
  done
  for invalid in "${minor}.0-build20200101" "${minor}-build20200101" \
    "${minor}-r0-build20200101" "${minor}-r01-build20200101" \
    "${minor}-r-build20200101" "${minor}-r1-build2020010"; do
    if bash "${ROOT}/scripts/source.sh" "${invalid}" >/dev/null 2>&1; then
      echo "unexpectedly accepted ${invalid}" >&2
      exit 1
    fi
  done
  pseudo="${minor}.0-0.20261009105818-${commit:0:12}-build20261015"
  if bash "${ROOT}/scripts/source.sh" "${pseudo}" >/dev/null 2>&1; then
    echo "unexpectedly accepted pseudo-version release tag ${pseudo}" >&2
    exit 1
  fi
done < <(jq -r 'to_entries[] | "\(.key) \(.value)"' "${ROOT}/k3s-sources.json")

for unsupported in v1.999-r1-build20261015 not-a-release; do
  if bash "${ROOT}/scripts/source.sh" "${unsupported}" >/dev/null 2>&1; then
    echo "unexpectedly accepted ${unsupported}" >&2
    exit 1
  fi
done
