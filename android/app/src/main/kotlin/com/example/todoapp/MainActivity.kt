package com.example.todoapp

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.math.log

class MainActivity: FlutterActivity() {
    private val CHANNEL = "task_widget_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "updateCounts" -> {

                        val args = call.arguments as Map<*, *>
                        val done = (args["done"] as Number?)?.toInt() ?: 0
                        val todo = (args["todo"] as Number?)?.toInt() ?: 0

                        // 1) persist
                        val prefs = applicationContext.getSharedPreferences("TASK_WIDGET", Context.MODE_PRIVATE)
                        prefs.edit().putInt("done_count", done).putInt("todo_count", todo).apply()

                        // 2) update
                        val manager = AppWidgetManager.getInstance(applicationContext)
                        val component = ComponentName(applicationContext, TaskWidgetProvider::class.java)
                        val ids = manager.getAppWidgetIds(component)
                        if (ids.isNotEmpty()) {
                            val provider = TaskWidgetProvider()
                            provider.onUpdate(applicationContext, manager, ids)
                            print("Widget updated: done=$done, todo=$todo")
                            Log.d("TaskWidget","updateCounts called: done=$done todo=$todo")
                        }
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}