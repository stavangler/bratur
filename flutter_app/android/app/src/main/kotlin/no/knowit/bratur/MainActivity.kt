package no.knowit.bratur

import android.os.Build
import android.os.Bundle
import android.view.View.*
import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        drawUnderSystemUi()
    }

    override fun onPostResume() {
        super.onPostResume()
        drawUnderSystemUi()
    }

    private fun drawUnderSystemUi() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val window = window
            window.statusBarColor = 0x00000000
            window.navigationBarColor = 0x4B6455
            val baseFlags = SYSTEM_UI_FLAG_LAYOUT_STABLE or
                    SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or
                    SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
            window.decorView.systemUiVisibility = baseFlags

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                window.navigationBarColor = 0x4B6455
                window.decorView.systemUiVisibility = baseFlags or SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR
            }
        }
    }
}
