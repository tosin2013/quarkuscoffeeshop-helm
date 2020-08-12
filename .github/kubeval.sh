#!/bin/bash
set -euo pipefail

CHART_DIRS="charts/quarkus-helm-chart"
KUBEVAL_VERSION="0.15.0"
SCHEMA_LOCATION="https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/"
REPO_PATH="gh-pages"

# install kubeval
curl --silent --show-error --fail --location --output /tmp/kubeval.tar.gz https://github.com/instrumenta/kubeval/releases/download/"${KUBEVAL_VERSION}"/kubeval-linux-amd64.tar.gz
tar -xf /tmp/kubeval.tar.gz kubeval

# validate charts
for CHART_DIR in ${CHART_DIRS}; do
  helm template --values "${CHART_DIR}"/values.yaml "${CHART_DIR}" | ./kubeval --strict --ignore-missing-schemas --kubernetes-version "${KUBERNETES_VERSION#v}" --schema-location "${SCHEMA_LOCATION}"
done
