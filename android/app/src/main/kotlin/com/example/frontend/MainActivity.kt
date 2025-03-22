package com.example.frontend

import android.content.Context
import android.content.pm.PackageManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.provider.Settings
import java.util.Calendar

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.frontend/app_management"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getInstalledApps" -> {
                    val apps                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          = getInstalledAppsWithUsage()
                    result.success(apps)
                }
                "openSettings" -> {
                    openSettings()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getApps(): List<String> {
        val packageManager = packageManager
        val apps = packageManager.getInstalledApplications(PackageManager.GET_META_DATA)
        return apps.map { it.packageName }
    }

    private fun getAppUsageStats(): List<UsageStats> {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val calendar = Calendar.getInstance()
        calendar.add(Calendar.DAY_OF_YEAR, -7)
        val startTime = calendar.timeInMillis
        val endTime = System.currentTimeMillis()

        return usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_DAILY,
            startTime,
            endTime
        ) ?: emptyList()
    }

    private fun getInstalledApps(): List<String> {
        val installedApps = getApps() // Get the list of installed apps
        val usageStats = getAppUsageStats() // Get usage stats for the last week

        val activeApps = mutableListOf<String>()
        for (app in installedApps) {
            val usage = usageStats.find { it.packageName == app }
            if (usage != null && usage.totalTimeInForeground > 0) {
                activeApps.add(app) // Add to the list if it was used in the last week
            }
        }

        return activeApps
    }

    private fun requestUsageStatsPermission() {
        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
        startActivity(intent)
    }

    private fun openSettings() {
        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
        startActivity(intent)
    }
}
