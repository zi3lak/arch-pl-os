#!/usr/bin/env bash
set -Eeuo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")"; git pull --ff-only; exec ./instaluj.sh --bez-pakietow --bez-locale
