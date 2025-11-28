# Flutter
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# flutter_contacts — ГЛАВНЫЙ ВИНОВНИК
-keep class com.github.mirfatif.** { *; }
-dontwarn com.github.mirfatif.**

# permission_handler
-keep class com.baseflow.permissionhandler.** { *; }
-dontwarn com.baseflow.permissionhandler.**

# share_plus
-keep class com.linusu.** { *; }

# Общее
-keepattributes *Annotation*,Signature
-keepattributes SourceFile,LineNumberTable