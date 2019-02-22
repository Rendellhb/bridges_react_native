# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /usr/local/Cellar/android-sdk/24.3.3/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}
# Active Android
-keep class com.activeandroid.** { *; }
-keep class com.activeandroid.**.** { *; }
-keep class * extends com.activeandroid.Model
-keep class * extends com.activeandroid.serializer.TypeSerializer
-keepattributes Column
-keepattributes Table
-keepclasseswithmembers class * { @com.activeandroid.annotation.Column <fields>; }
# Firebase
-dontwarn com.google.**
# Gson
-keep class com.google.gson.** { *; }
-keep class com.google.gson.stream.** { *; }
-keep class sun.misc.Unsafe { *; }
-keepattributes Expose
-keepattributes SerializedName -keepattributes Since
-keepattributes Until
# Parcelable
-keep class * implements android.os.Parcelable { public static android.os.Parcelable$Creator *; }
# OkHttp
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**
# Okio
-dontwarn okio.**
 # Retrofit
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-keepattributes Signature -keepattributes Exceptions -keepclasseswithmembers class * { @retrofit2.http.* <methods>; }
-keepattributes Signature # Resolve issue must be of type Callback or Callback<? super X>. Found: interface retrofit.Callback
#Line numbers
-renamesourcefileattribute SourceFile -keepattributes SourceFile,LineNumberTable
# OTA keys SDK
-keep class com.otakeys.sdk.R { *; }
-keepnames class com.otakeys.sdk.database.VirtualKey -keepnames class com.otakeys.sdk.database.Key
-keepnames class com.otakeys.sdk.database.VehicleSynthesis -keepnames class com.otakeys.sdk.database.Vehicle
-keepnames class com.otakeys.sdk.database.LastVehicleSynthesis -keepnames class com.otakeys.sdk.database.LogAction
-keep class com.otakeys.sdk.push.** { *; }
-keep class com.otakeys.sdk.csm.** { *; }
-keep class com.otakeys.sdk.IOtaKeysApplication { *; }
-keep class com.otakeys.sdk.service.api.** { *; }
-keep class com.otakeys.sdk.service.ble.** { *; }
-keep class com.otakeys.sdk.service.nfc.** { *; }
-keep class com.otakeys.sdk.service.push.** { *; }
-keep class com.otakeys.sdk.service.core.** { *; }
-keep class com.otakeys.sdk.service.object.** { *; }
-keep class com.otakeys.sdk.service.Api { *; }
-keep class com.otakeys.sdk.service.Ble { *; }
-keep class com.otakeys.sdk.service.Core { *; }
-keep class com.otakeys.sdk.service.Nfc { *; }
-keep class com.otakeys.sdk.service.Push { *; }
-keep class com.otakeys.sdk.core.tool.OtaLogger
-keep class com.otakeys.sdk.core.tool.HashingTool { *; }
-keep class com.otakeys.sdk.api.serializer.DateTimeSerializer { *; }
-keep class com.otakeys.sdk.nfc.service.NfcHceService { *; }
-keepnames class com.otakeys.sdk.service.OtaKeysService { *; }
-keep class com.otakeys.sdk.service.OtaKeysService$SekorBinder { *; }
-keep class com.otakeys.sdk.service.OtaKeysService {public <methods>;}
-keep class com.otakeys.sdk.KeycoreApplication { *; }
-keep class com.otakeys.sdk.OtaKeysApplication { *; }
-keep class com.otakeys.sdk.IOtaKeysApplication { *; }
-keep class com.otakeys.sdk.OtaNotificationInterface { *; }
-keep class com.otakeys.sdk.core.exception.CoreException { *; }
-dontwarn com.otakeys.sdk.KeycoreApplication
-dontwarn com.otakeys.sdk.service.KeycoreService
