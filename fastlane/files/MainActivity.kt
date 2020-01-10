

import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.PluginRegistry

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
        registerFlutterChannelPlugin(this)
    }

    /// 註冊自訂插件
    private fun registerFlutterChannelPlugin(registrar: PluginRegistry) {
        FlutterChannel.registerWith(registrar.registrarFor(FlutterChannel::class.java.name))
    }
}
