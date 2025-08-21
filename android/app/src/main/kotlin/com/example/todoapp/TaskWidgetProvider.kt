package com.example.todoapp

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews

class TaskWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(context: Context, manager: AppWidgetManager, appWidgetIds: IntArray) {
        for (id in appWidgetIds) {
            val views = RemoteViews(context.packageName, R.layout.widget_task)
            val prefs = context.getSharedPreferences("TASK_WIDGET", Context.MODE_PRIVATE)
            val done = prefs.getInt("done_count", 0)
            val todo = prefs.getInt("todo_count", 0)
            views.setTextViewText(R.id.txtSummary, "Hammasi: ${done+todo} Bajarilgan: $done  Bajarilmagan: $todo")
            manager.updateAppWidget(id, views)
        }
    }
}