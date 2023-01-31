#!/bin/bash -l

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename ${__file} .sh)"

site_dir="${1:-public}"
config="${2:-config/mkdocs.yml}"

# Install mkdocs from .devcontainer in a sub-shell
cp -a .devcontainer/mkdocs-edu /
(cd /mkdocs-edu && poetry config virtualenvs.create false && poetry install)

python --version
mkdocs --version

echo "Building site"
mkdocs build --clean --config-file ${config} --site-dir ${site_dir}
