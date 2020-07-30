#!/bin/bash -ex

cd "$(dirname "$0")"
LONGHASH=$(cd libgit2 && git log -1 --format=%H)
HASH=${LONGHASH:0:7}

echo "$LONGHASH" > "nuget.package/libgit2/libgit2_hash.txt"

for file in nuget.package/build/LibGit2Sharp.NativeBinaries.props nuget.package/build/net46/LibGit2Sharp.NativeBinaries.props; do
	perl -pi -e "s@<libgit2_hash>.*</libgit2_hash>@<libgit2_hash>$LONGHASH</libgit2_hash>@" "$file"
	perl -pi -e "s@<libgit2_filename>.*</libgit2_filename>@<libgit2_filename>git2-$HASH</libgit2_filename>@" "$file"
done

perl -pi -e "s@dll=\"git2-.*\" target=\"lib/linux-x64/libgit2-.*.so\" /@dll=\"git2-$HASH\" target=\"lib/linux-x64/libgit2-$HASH.so\" /@" nuget.package/libgit2/LibGit2Sharp.dll.config
perl -pi -e "s@dll=\"git2-.*\" target=\"lib/osx/libgit2-.*.dylib\" /@dll=\"git2-$HASH\" target=\"lib/osx/libgit2-$HASH.dylib\" /@" nuget.package/libgit2/LibGit2Sharp.dll.config
