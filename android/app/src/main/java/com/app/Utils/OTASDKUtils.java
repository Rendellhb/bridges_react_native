package com.app.Utils;

import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import com.otakeys.sdk.service.object.request.OtaKeyRequest;
import com.otakeys.sdk.service.object.request.OtaSessionRequest;
import com.otakeys.sdk.service.object.response.OtaKey;
import com.otakeys.sdk.service.object.response.OtaLastVehicleData;
import com.otakeys.sdk.service.object.response.OtaVehicleData;

import org.joda.time.DateTime;

import java.io.IOException;
import java.util.List;

public class OTASDKUtils {
  private static boolean SDK_READY = false;

  public static OtaSessionRequest getOtaSessionRequestFromJson(String json) {
    return getGson().fromJson(json, OtaSessionRequest.class);
  }

  public static OtaKeyRequest getOtaKeyRequestFromJson(String json, OTAKeyRequestBuilder builderEnum ) {
    Gson gson = getGson();
    OtaKeyRequest keyrequest = gson.fromJson(json, OtaKeyRequest.class);

    switch (builderEnum) {
      case CREATE_KEY:
        return buildCreateKey(keyrequest);
      case ENABLE_KEY:
        return buildEnableKey(keyrequest);
      case GENERATE_TOKENS:
        return buildGenerateTokens(keyrequest);
      case END_KEY:
        return buildEndKey(keyrequest);
      case UPDATE_KEY:
        return buildUpdateKey(keyrequest);
      case GET_KEY:
        return buildGetKey(keyrequest);
      default:
        return keyrequest;
    }
  }

  public static OtaKey getOtaKeyFromJson(String json) {
    Gson gson = getGson();
    return gson.fromJson(json, OtaKey.class);
  }

  public static boolean isSdkReady() {
      return SDK_READY;
  }

  public static void setSdkReady(boolean isReady) {
      SDK_READY = isReady;
  }

  public static String getJsonFromOtaKey(OtaKey key) {
    Gson gson = getGson();
    return gson.toJson(key);
  }

  public static String getJsonFromOtaKeys(List<OtaKey> keys) {
    Gson gson = getGson();
    return gson.toJson(keys);
  }

  public static String getJsonFromOtaVehicleData(OtaVehicleData otaVehicleData) {
    Gson gson = getGson();
    return gson.toJson(otaVehicleData);
  }

  public static String getJsonFromOtaVehicleDataList(List<OtaVehicleData> otaVehiclesData) {
    return getGson().toJson(otaVehiclesData);
  }

  public static String getJsonFromOtaLastVehicleData(OtaLastVehicleData otaLastVehicleData) {
    return getGson().toJson(otaLastVehicleData);
  }

  private static Gson getGson() {
    return new GsonBuilder()
            .registerTypeAdapter(DateTime.class, new DateLongFormatTypeAdapter())
            .create();
  }

  private static OtaKeyRequest buildCreateKey(OtaKeyRequest keyrequest) {
    OtaKeyRequest.CreateKeyBuilder builder = new OtaKeyRequest.CreateKeyBuilder(keyrequest.getEndDate())
            .setVehicleExtId(keyrequest.getVehicleExtId())
            .setExtId(keyrequest.getExtId())
            .setSecurity(keyrequest.getSecurity());

    if (keyrequest.getBeginDate() != null) {
      builder.setBeginDate(keyrequest.getBeginDate());
    }

    if (keyrequest.getVehicleId() != null) {
      builder.setVehicleId(keyrequest.getVehicleId());
    }

    if (keyrequest.getTokenNbr() != null)
      builder.setTokenNumber(keyrequest.getTokenNbr());

    if (keyrequest.isEnableNow() != null)
      builder.setEnableNow(keyrequest.isEnableNow());

    return builder.create();
  }

  private static OtaKeyRequest buildEnableKey(OtaKeyRequest keyrequest) {
    OtaKeyRequest.EnableKeyBuilder builder = new OtaKeyRequest.EnableKeyBuilder(keyrequest.getOtaId())
            .setSecurity(keyrequest.getSecurity());

    if (keyrequest.getTokenNbr() != null)
      builder.setTokenNumber(keyrequest.getTokenNbr());

    return builder.create();
  }

  private static OtaKeyRequest buildGenerateTokens(OtaKeyRequest keyrequest) {
    return new OtaKeyRequest.GenerateVirtualKeys(keyrequest.getOtaId(), keyrequest.getTokenNbr())
            .setExtId(keyrequest.getExtId())
            .create();

  }

  private static OtaKeyRequest buildUpdateKey(OtaKeyRequest keyrequest) {
    OtaKeyRequest.UpdateKeyBuilder builder = new OtaKeyRequest.UpdateKeyBuilder(
            keyrequest.getOtaId(), keyrequest.getBeginDate(), keyrequest.getEndDate())
            .setSecurity(keyrequest.getSecurity());

    if (keyrequest.getTokenNbr() != null) {
      builder.setTokenNumber(keyrequest.getTokenNbr());
    }

    if (keyrequest.isEnableNow() != null)
      builder.setEnableNow(keyrequest.isEnableNow());

    return builder.create();
  }

  private static OtaKeyRequest buildEndKey(OtaKeyRequest keyrequest) {
    return new OtaKeyRequest.EndKeyBuilder(keyrequest.getOtaId())
            .create();
  }

  private static OtaKeyRequest buildGetKey(OtaKeyRequest keyrequest) {
    OtaKeyRequest.GetKeyBuilder builder = new OtaKeyRequest.GetKeyBuilder()
            .setExtId(keyrequest.getExtId());

    if (keyrequest.getOtaId() != null) {
      builder.setOtaId(keyrequest.getOtaId());
    }

    return builder.create();
  }
}

class DateLongFormatTypeAdapter extends TypeAdapter<DateTime> {

  @Override
  public void write(JsonWriter out, DateTime value) throws IOException {
    out.value(value.getMillis());
  }

  @Override
  public DateTime read(JsonReader in) throws IOException {
    return new DateTime(in.nextLong());
  }

}
