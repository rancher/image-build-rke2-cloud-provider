#!/bin/bash

set -euo pipefail

fail() {
  echo "source: $*" >&2
  exit 1
}

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
SOURCE="${1:-}"
if [[ "${SOURCE}" =~ ^v?(1\.[0-9]+)$ ]]; then
  MINOR="v${BASH_REMATCH[1]}"
elif [[ "${SOURCE}" =~ ^(v1\.[0-9]+)-r[1-9][0-9]*-build[0-9]{8}$ ]]; then
  MINOR="${BASH_REMATCH[1]}"
else
  fail "expected a minor (v1.34) or release tag (v1.34-r1-buildYYYYMMDD), got '${SOURCE}'"
fi

MANIFEST="${ROOT}/k3s-sources.json"
jq -e '
  type == "object" and length == 4 and
  all(to_entries[];
    (.key | test("^v1\\.[0-9]+$")) and
    (.value | type == "string" and test("^[0-9a-f]{40}$")))
' "${MANIFEST}" >/dev/null || fail "invalid source manifest: ${MANIFEST}"
COMMIT=$(jq -er --arg minor "${MINOR}" '.[$minor]' "${MANIFEST}") ||
  fail "no k3s commit for ${MINOR} in ${MANIFEST}"
printf '%s %s\n' "${MINOR}" "${COMMIT}"
