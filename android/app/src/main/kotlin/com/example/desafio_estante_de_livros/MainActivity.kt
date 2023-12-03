package com.example.desafio_estante_de_livros

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "my_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getAndroidVersion") {
                val androidVersion = getAndroidVersion()
                result.success(androidVersion)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getAndroidVersion(): String {
        return android.os.Build.VERSION.RELEASE
    }
}
