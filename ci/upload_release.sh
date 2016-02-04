#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [ -z "${BOX_VERSION}" ]; then
  echo "BOX_VERSION must be set" >&2
  exit 1
fi

build_dir=$(cd "$(dirname "${BASH_SOURCE}")/.." && pwd -P)

echo "Building mesosphere/aws-cli"
cd "${build_dir}/aws-cli"
docker build -t mesosphere/aws-cli .

echo "Uploading dcos-centos-virtualbox-${BOX_VERSION}.box"
cd "${build_dir}"
aws-cli/aws.sh s3 cp dcos-centos-virtualbox-${BOX_VERSION}.box s3://dcos-vagrant/