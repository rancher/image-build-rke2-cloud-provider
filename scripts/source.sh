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
  REVISION=""
elif [[ "${SOURCE}" =~ ^(v1\.[0-9]+-r[1-9][0-9]*)(-build[0-9]{8})?$ ]]; then
  MINOR="${BASH_REMATCH[1]%-r*}"
  REVISION="${BASH_REMATCH[1]##*-}"
else
  fail "expected a minor (v1.34), revision (v1.34-r1), or release tag (v1.34-r1-buildYYYYMMDD), got '${SOURCE}'"
fi

MANIFEST="${ROOT}/k3s-sources.json"
jq -e '
  type == "object" and length > 0 and
  all(to_entries[];
    (.key | test("^v1\\.[0-9]+$")) and
    (.value | type == "object" and (keys | sort) == ["commit", "revision"] and
      (.revision | type == "string" and test("^r[1-9][0-9]*$")) and
      (.commit | type == "string" and test("^[0-9a-f]{40}$"))))
' "${MANIFEST}" >/dev/null || fail "invalid source manifest: ${MANIFEST}"
if [[ -z "${REVISION}" ]]; then
  REVISION=$(jq -er --arg minor "${MINOR}" '.[$minor].revision' "${MANIFEST}") ||
    fail "no k3s revision for ${MINOR} in ${MANIFEST}"
fi
COMMIT=$(jq -er --arg minor "${MINOR}" --arg revision "${REVISION}" \
  'select(.[$minor].revision == $revision) | .[$minor].commit' "${MANIFEST}") ||
  fail "no k3s commit for ${MINOR}-${REVISION} in ${MANIFEST}"
printf '%s-%s %s\n' "${MINOR}" "${REVISION}" "${COMMIT}"
