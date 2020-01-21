package com.manichord.sketchnotes

import io.flutter.app.FlutterApplication
import io.sentry.Sentry
import io.sentry.android.AndroidSentryClientFactory


class SketchNotesApplication: FlutterApplication() {

    override fun onCreate()
    {
        super.onCreate()
        Sentry.init(AndroidSentryClientFactory(this))
    }
}