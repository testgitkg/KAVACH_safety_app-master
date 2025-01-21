package com.example.kavach_project

import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "send_sms_channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "sendSMS") {
                val recipient = call.argument<String>("recipient")
                val body = call.argument<String>("body")
                if (recipient != null && body != null) {
                    sendSMS(recipient, body)
                    result.success(true)
                } else {
                    result.error("MISSING_PARAMS", "Recipient or body is null", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun sendSMS(recipient: String, body: String) {
        val intent = Intent(Intent.ACTION_SENDTO).apply {
            data = Uri.parse("smsto:$recipient")
            putExtra("sms_body", body)
        }
        startActivity(intent)
    }
}