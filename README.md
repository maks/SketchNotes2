# sketchnotes_flutter

Second generation of the [Sketch Notes Android app](https://play.google.com/store/apps/details?id=com.manichord.sketchnotes&hl=en_AU), now built with Flutter.

It is forked from the [excellent drawapp sample app](https://github.com/SnakeyHips/drawapp).

## Status

[![Codemagic build status](https://api.codemagic.io/apps/5c2950cb57670e000d8486d9/5c2950cb57670e000d8486d8/status_badge.svg)](https://codemagic.io/apps/5c2950cb57670e000d8486d9/5c2950cb57670e000d8486d8/latest_build)

Currently under active development and NOT YET PUBLISHED on Google Play.

## Building

Until [this bug with code gen on hot-reload is fixed](https://github.com/dart-lang/build/issues/1132) to re-generate code you need to run:
`flutter packages pub run build_runner build --delete-conflicting-outputs`

### Sentry config

The DSN needs to be supplied by the build environment.

For native Android, this is via a properties file in: `app/src/main/resources` which is created by the following custom script in Codemagic and for Flutter, this is via a Dart file created at build time also by this script:
```shell
#!/usr/bin/env sh

set -e # exit on first failed commandset

mkdir -p $FCI_BUILD_DIR/android/app/src/main/resources
echo dsn=$SENTRY_DSN > $FCI_BUILD_DIR/android/app/src/main/resources/sentry.properties

echo "const DSN='$SENTRY_DSN';" > $FCI_BUILD_DIR/lib/env.dart
```

## License

MIT License

Copyright (c) 2018 Jake Gough
Copyright (c) 2020 Maksim Lin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.