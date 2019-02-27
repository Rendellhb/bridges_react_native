package com.app;

import android.app.Application;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.support.v4.app.NotificationCompat;

import com.app.bridge.OTABridge;
import com.app.bridge.OTABridgePackage;
import com.facebook.react.ReactApplication;
import com.facebook.react.ReactNativeHost;
import com.facebook.react.ReactPackage;
import com.facebook.react.shell.MainReactPackage;
import com.facebook.soloader.SoLoader;
import com.otakeys.sdk.OtaNotificationInterface;

import java.util.Arrays;
import java.util.List;

public class MainApplication extends Application implements ReactApplication, OtaNotificationInterface {

  private Notification notification;

  private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {
    @Override
    public boolean getUseDeveloperSupport() {
      return BuildConfig.DEBUG;
    }

    @Override
    protected List<ReactPackage> getPackages() {
      return Arrays.asList(
          new MainReactPackage(),
          new OTABridgePackage()
      );
    }

    @Override
    protected String getJSMainModuleName() {
      return "index";
    }
  };

  @Override
  public ReactNativeHost getReactNativeHost() {
    return mReactNativeHost;
  }

  @Override
  public void onCreate() {
    super.onCreate();
    SoLoader.init(this, /* native exopackage */ false);
    //Doing OTA Stuff
    configureOTASDKNotification(this);
  }

  private void configureOTASDKNotification(Context context) {
    String BLE_CHANNEL_ID = "BLE_CHANNEL_ID";
    String BLE_CHANNEL_NAME = "Bluetooth service";

    this.notification = new Notification.Builder(this).build();

    final Intent intent = OTABridge.getCallingIntent();
    intent.addCategory(Intent.CATEGORY_DEFAULT);
    PendingIntent pendingIntent = PendingIntent.getActivity(context,
            NOTIFICATION_ID, intent, PendingIntent.FLAG_UPDATE_CURRENT);

    final NotificationCompat.Builder builder = new NotificationCompat.Builder(this, BLE_CHANNEL_ID)
            .setContentTitle("Bluetooth service")
            .setContentText("Bluetooth connection is active")
            .setContentIntent(pendingIntent);

    NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

    //This is mandatory for Oreo versions
    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
      int importance = NotificationManager.IMPORTANCE_HIGH;
      NotificationChannel mChannel = new NotificationChannel(BLE_CHANNEL_ID, BLE_CHANNEL_NAME, importance);
      notificationManager.createNotificationChannel(mChannel);
      builder.setChannelId(BLE_CHANNEL_ID);
    }

    this.notification = builder.build();
  }

  @Override
  public Notification getNotification() {
    return notification;
  }

  @Override
  public void setNotification(Notification notification) {
    this.notification = notification;
  }
}
