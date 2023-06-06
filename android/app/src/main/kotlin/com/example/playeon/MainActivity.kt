package com.example.playeon

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import androidx.appcompat.app.AlertDialog
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import android.content.DialogInterface



class MainActivity : FlutterActivity() {
    private val CHANNEL = "BrightnessControl"
    private val REQUEST_WRITE_SETTINGS = 123
    private var brightnessResult: MethodChannel.Result? = null
    private var brightnessValue: Double? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        brightnessResult = null
        brightnessValue = null
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setBrightness") {
                val value = call.argument<Double>("brightness")
                if (value != null) {
                    brightnessResult = result
                    brightnessValue = value
                    checkAndRequestPermission()
                } else {
                    result.error("INVALID_ARGUMENTS", "Invalid brightness value", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun checkAndRequestPermission() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_SETTINGS) == PackageManager.PERMISSION_GRANTED) {
            setBrightness()
        } else {
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.WRITE_SETTINGS), REQUEST_WRITE_SETTINGS)
        }
    }

    private fun setBrightness() {
        val contentResolver = contentResolver
        val window = window
        val layoutParams = window.attributes

        try {
            Settings.System.putInt(
                contentResolver,
                Settings.System.SCREEN_BRIGHTNESS_MODE,
                Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL
            )
            layoutParams.screenBrightness = brightnessValue!!.toFloat()
            window.attributes = layoutParams
            brightnessResult?.success(true)
        } catch (e: Exception) {
            brightnessResult?.error("ERROR", "Failed to set brightness: ${e.message}", null)
        } finally {
            brightnessResult = null
            brightnessValue = null
        }
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_WRITE_SETTINGS) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                setBrightness()
            } else {
                showPermissionDeniedDialog()
            }
            brightnessResult = null
            brightnessValue = null
        }
    }

    private fun showPermissionDeniedDialog() {
       val dialogBuilder = AlertDialog.Builder(this)
             .setTitle("Permission Required")
        .setMessage("To set the screen brightness, you need to grant the Write Settings permission. Please go to the App Settings and enable the permission manually.")
        .setPositiveButton("OK") { dialog, _ ->
            dialog.dismiss()
        }

    val alertDialog = dialogBuilder.create()
    alertDialog.show()
    }

    private fun openAppSettings() {
        val intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
        intent.data = Uri.fromParts("package", packageName, null)
        startActivity(intent)
    }
}
