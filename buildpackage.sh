#!/bin/bash -eux

set -o pipefail
IFS=$'\n\t'

cd "$(dirname "$0")"

mono --debug nuget.exe pack nuget.package/NativeBinaries.nuspec -Version 3.0.0-rolf -NoPackageAnalysis
