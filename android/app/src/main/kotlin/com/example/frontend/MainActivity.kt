package com.example.frontend

import android.app.admin.DevicePolicyManager
import android.content.ComponentName
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
    private val CHANNEL = "com.example.frontend/app_usage"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getInstalledAppsWithUsage" -> {
                    val appsWithUsage = getInstalledAppsWithUsage()
                    result.success(appsWithUsage)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getInstalledApps(): List<String> {
        val packageManager = packageManager
        val apps = packageManager.getInstalledApplications(PackageManager.GET_META_DATA)
        return apps.map { it.packageName }
    }

    private fun getAppUsageStats(): List<UsageStats> {
        val usageStatsManager = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val calendar = Calendar.getInstance()
        calendar.add(Calendar.DAY_OF_YEAR, -7) // Get stats for the last 7 days
        val startTime = calendar.timeInMillis
        val endTime = System.currentTimeMillis()

        return usageStatsManager.queryUsageStats(
            UsageStatsManager.INTERVAL_DAILY,
            startTime,
            endTime
        ) ?: emptyList()
    }

    private fun getInstalledAppsWithUsage(): Map<String, Long> {
        val installedApps = getInstalledApps()
        val usageStats = getAppUsageStats()

        val appUsageMap = mutableMapOf<String, Long>()
        for (app in installedApps) {
            val usage = usageStats.find { it.packageName == app }?.totalTimeInForeground ?: 0
            appUsageMap[app] = usage
        }

        return appUsageMap
    }

    private fun requestUsageStatsPermission() {
        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
        startActivity(intent)
    }

    private fun openSetings() {
        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
        startActivity(intent)
    }
}