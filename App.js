/**
 * OTASDK API - Implemented only for iOS
 * https://github.com/Rendellhb
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Button,
  ScrollView,
  NativeModules
} from 'react-native';

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = { something: '' };

    this.lastVehicleSynthesisObj = {
      lastCaptureDate: '01-01-2001',
      gpsCoordinates: {
        initialCaptureDate: '01-01-2001',
        lastCaptureDate: '01-01-2001',
        latitude: -9873.084,
        longitude: 727734.09884,
      },
      doorsState: 1,
      engineRunning: true,
      lastMileageCaptureDate: '01-01-2001',
      mileage: 234,
      lastEnergyCaptureDate: '01-01-2001',
      energyLevel: 2,
      batteryVoltage: 12,
      connectedToCharger: false,
      malfunctionIndicatorLamp: false,
      energyType: 0,
      fuelUnit: 0,
      odometerUnit: 1,
      activeDtcNumber: 2
    };

    this.vehicleData = {
      date: '01-03-2018',
      mileageStart: 23784,
      mileageCurrent: 893795,
      connectedToLoader: true,
      energyStart: 9374,
      energyCurrent: 91,
      engineRunning: false,
      doorsState: 0,
      malfunctionIndicatorLamp: true,
      gpsLatitude: -9873.084,
      gpsLongitude: 727734.09884,
      gpsAccuracy: 30,
      gpsCaptureDate: '03-03-2008',
      gprsLatitude: 8374,
      gprsLongitude: 9264,
      gprsLastCaptureDate: '05-09-1990',
      gprsInitialCaptureDate: '03-03-1990',
      lastMileageCaptureDate: '05-09-1990',
      lastEnergyCaptureDate: '05-09-1990',
      fuelUnit: 1,
      odometerUnit: 1,
      synthesisVersion: 2,
      activeDtcErrorCode: 3,
      batteryVoltage: 12,
      energyType: 1,
      distanceType: 2,
      timestamp: 1550520159,
      sdkGpsLatitude: 773,
      sdkGpsLongitude: 97623,
      sdkGpsAccuracy: 823664,
      sdkGpsCaptureDate: '01-01-2001'
    };

    this.otaKeyRequest = {
      otaId: '1',
      extId: '1',
      beginDate: 1550685803,
      endDate: 1550685803,
      vehicleId: '1',
      vehicleExtId: '1',
      enableNow: true,
      tokenAmount: '16',
      singleShotSecurity: true,
      security: 'token'
    };

    this.otaKeyPublic = {
      otaId: '1',
      extId: '1',
      beginDate: '01-03-2019',
      endDate: '01-03-2019',
      enabled: true,
      mileageLimit: '16',
      singleShotSecurity: true,
      keyArgs: 'keyArgs',
      keySensitiveArgs: 'KeySensitiveArgs',
      vehicle: {
        otaId: '1',
        extId: '1',
        vin: 'vin',
        brand: 'brand',
        model: 'model',
        plate: 'plate',
        year: 1998,
        enabled: true,
        engine: 'engine',
        mileageOffset: '123',
        vehicleData: this.vehicleData
      },
      lastVehicleSynthesis: this.lasVehicleSynthesisObj
    };
  }

  /*
                      ****** UNCOMENT FOR LEARNING PURPOSES ******
    The easiest way to start creating a bridge, send a string get it back and print
    I left this one just for an example so you guys can use as a guide
  */
  async printAwesometext() {
    try {
      const something1 = await NativeModules.OTABridge.printSomething('Funcionalidades do OTAManager');
      this.setState(() => ({
        something: something1
      }));
    } catch (e) {
      console.log(`Erro do OTA ${e}`);
    }
  }

  async openSessionWithToken() {
    try {
      const result = await NativeModules.OTABridge.openSessionWithToken('VCpCTVlS3P535Y7ZpGjE0YGJ91dfgqRA');
      console.log(result);
    } catch (e) {
      console.log(`Erro do OTA ${e}`);
    }
  }

  async authenticated() {
    try {
      const result = await NativeModules.OTABridge.authenticated();
      console.log(result);
    } catch (e) {
      console.log(`Erro do OTA ${e}`);
    }
  }

  async configureWithAppId() {
    try {
      const result = await NativeModules.OTABridge.configureWithAppId('appId', 'sdkInstanceId');
      console.log(result);
    } catch (e) {
      console.log(`Erro do OTA ${e}`);
    }
  }

  async closeSession() {
    try {
      const result = await NativeModules.OTABridge.closeSession();
      console.log(result);
    } catch (e) {
      console.log(`Erro do OTA ${e}`);
    }
  }

  async switchToKeyWithID() {
    try {
      const result = await NativeModules.OTABridge.switchToKeyWithID('otaKey');
      console.log(result);
    } catch (e) {
      console.log(`Erro do OTA ${e}`);
    }
  }

  async accessDeviceTokenWithForceRefresh() {
    try {
      const result = await NativeModules.OTABridge.accessDeviceTokenWithForceRefresh(false);
      console.log(result);
    } catch (e) {
      console.log(`Erro do OTA ${e}`);
    }
  }

  async createKey() {
    try {
      const otaKeyRequest = {
        otaId: '1',
        extId: '1',
        beginDate: 1550685803,
        endDate: 1550685803,
        vehicleId: '1',
        vehicleExtId: '1',
        singleShotSecurity: true,
        security: 'token'
      };
      const result = await NativeModules.OTABridge.createKey(JSON.stringify(otaKeyRequest));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  updateKey() {
    try {
      const result = NativeModules.OTABridge.updateKey(JSON.stringify(this.otaKeyRequest));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  enableKey() {
    try {
      const result = NativeModules.OTABridge.enableKey(JSON.stringify(this.otaKeyRequest));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  endKey() {
    try {
      const result = NativeModules.OTABridge.endKey(JSON.stringify(this.otaKeyRequest));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  endKeyWithId() {
    try {
      const result = NativeModules.OTABridge.endKeyWithId('keyID');
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  keysWithSuccess() {
    try {
      const result = NativeModules.OTABridge.keysWithSuccess();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }


  scanForVehicleWithCompletion() {
    try {
      const result = NativeModules.OTABridge.scanForVehicleWithCompletion();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  scanForVehicleWithTimeout() {
    try {
      const result = NativeModules.OTABridge.scanForVehicleWithTimeout(30);
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  connectToVehicle() {
    try {
      const result = NativeModules.OTABridge.connectToVehicle();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  connectToVehicleWithCompletion() {
    try {
      const result = NativeModules.OTABridge.connectToVehicleWithCompletion();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  connectToVehicleWithTimeout() {
    try {
      const result = NativeModules.OTABridge.connectToVehicleWithTimeout(30);
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  connectedToVehicle() {
    try {
      const result = NativeModules.OTABridge.connectedToVehicle();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  async currentConnectionStatus() {
    try {
      const result = await NativeModules.OTABridge.currentConnectionStatus();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  disconnectFromVehicle() {
    try {
      const result = NativeModules.OTABridge.disconnectFromVehicle();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  unlockDoorsWithRequestVehicleData() {
    try {
      const result = NativeModules.OTABridge.unlockDoorsWithRequestVehicleData(true, true);
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  lockDoorsWithRequestVehicleData() {
    try {
      const result = NativeModules.OTABridge.lockDoorsWithRequestVehicleData(true);
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  vehicleDataWithSuccess() {
    try {
      const result = NativeModules.OTABridge.vehicleDataWithSuccess();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  lastVehicleSynthesisWithSuccess() {
    try {
      const result = NativeModules.OTABridge.lastVehicleSynthesisWithSuccess();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  lastVehicleSynthesis() {
    try {
      const result = NativeModules.OTABridge
        .lastVehicleSynthesis(JSON.stringify(this.otaKeyRequest));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  lastVehicleSynthesisForKeyWithId() {
    try {
      const result = NativeModules.OTABridge.lastVehicleSynthesisForKeyWithId('keyId');
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  enableEngineWithRequestVehicleData() {
    try {
      const result = NativeModules.OTABridge.enableEngineWithRequestVehicleData(true);
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  disableEngineWithRequestVehicleData() {
    try {
      const result = NativeModules.OTABridge.disableEngineWithRequestVehicleData(true);
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  unnamedAction1WithRequestVehicleData() {
    try {
      const result = NativeModules.OTABridge
        .unnamedAction1WithRequestVehicleData(JSON.stringify(this.vehicleData));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  unnamedAction2WithRequestVehicleData() {
    try {
      const result = NativeModules.OTABridge
        .unnamedAction2WithRequestVehicleData(JSON.stringify(this.vehicleData));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  unnamedAction3WithRequestVehicleData() {
    try {
      const result = NativeModules.OTABridge
        .unnamedAction3WithRequestVehicleData(JSON.stringify(this.vehicleData));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  unnamedAction4WithRequestVehicleData() {
    try {
      const result = NativeModules.OTABridge
        .unnamedAction4WithRequestVehicleData(JSON.stringify(this.vehicleData));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  unnamedAction5WithRequestVehicleData() {
    try {
      const result = NativeModules.OTABridge
        .unnamedAction5WithRequestVehicleData(JSON.stringify(this.vehicleData));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  unnamedAction6WithRequestVehicleData() {
    try {
      const result = NativeModules.OTABridge
        .unnamedAction6WithRequestVehicleData(JSON.stringify(this.vehicleData));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  generateTokens() {
    try {
      const result = NativeModules.OTABridge.generateTokens(JSON.stringify(this.otaKeyRequest));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  localKeys() {
    try {
      const result = NativeModules.OTABridge.localKeys();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  localKey() {
    try {
      const result = NativeModules.OTABridge.localKey();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  currentKey() {
    try {
      const result = NativeModules.OTABridge.currentKey();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  syncVehicleDataWithSuccess() {
    try {
      const result = NativeModules.OTABridge.syncVehicleDataWithSuccess();
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  activateLogging() {
    try {
      const result = NativeModules.OTABridge.activateLogging(true);
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  localKeyWithCompletionBlock() {
    try {
      const result = NativeModules.OTABridge
        .localKeyWithCompletionBlock(JSON.stringify(this.otaKeyPublic));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  render() {
    this.printAwesometext();
    return (
      <ScrollView>
        <View style={styles.container}>
          <Text style={styles.title}>{this.state.something}</Text>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="openSessionWithToken"
              onPress={this.openSessionWithToken}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="authenticated"
              onPress={this.authenticated}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="configureWithAppId"
              onPress={this.configureWithAppId}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="closeSession"
              onPress={this.closeSession}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="switchToKeyWithID"
              onPress={this.switchToKeyWithID}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="accessDeviceTokenWithForceRefresh"
              onPress={this.accessDeviceTokenWithForceRefresh}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="createKey"
              onPress={this.createKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="updateKey"
              onPress={this.updateKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="enableKey"
              onPress={this.enableKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="endKey"
              onPress={this.endKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="endKeyWithId"
              onPress={this.endKeyWithId}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="keysWithSuccess"
              onPress={this.keysWithSuccess}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="scanForVehicleWithCompletion"
              onPress={this.scanForVehicleWithCompletion}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="scanForVehicleWithTimeout"
              onPress={this.scanForVehicleWithTimeout}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="connectToVehicle"
              onPress={this.connectToVehicle}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="connectToVehicleWithCompletion"
              onPress={this.connectToVehicleWithCompletion}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="connectToVehicleWithTimeout"
              onPress={this.connectToVehicleWithTimeout}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="connectedToVehicle"
              onPress={this.connectedToVehicle}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="currentConnectionStatus"
              onPress={this.currentConnectionStatus}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="currentConnectionStatus"
              onPress={this.currentConnectionStatus}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="disconnectFromVehicle"
              onPress={this.disconnectFromVehicle}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unlockDoorsWithRequestVehicleData"
              onPress={this.unlockDoorsWithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="lockDoorsWithRequestVehicleData"
              onPress={this.lockDoorsWithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="vehicleDataWithSuccess"
              onPress={this.vehicleDataWithSuccess}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="lastVehicleSynthesisWithSuccess"
              onPress={this.lastVehicleSynthesisWithSuccess}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="lastVehicleSynthesis"
              onPress={this.lastVehicleSynthesis}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="lastVehicleSynthesisForKeyWithId"
              onPress={this.lastVehicleSynthesisForKeyWithId}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="enableEngineWithRequestVehicleData"
              onPress={this.enableEngineWithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="disableEngineWithRequestVehicleData"
              onPress={this.disableEngineWithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction1WithRequestVehicleData"
              onPress={this.unnamedAction1WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction2WithRequestVehicleData"
              onPress={this.unnamedAction2WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction3WithRequestVehicleData"
              onPress={this.unnamedAction3WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction4WithRequestVehicleData"
              onPress={this.unnamedAction4WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction5WithRequestVehicleData"
              onPress={this.unnamedAction5WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction6WithRequestVehicleData"
              onPress={this.unnamedAction6WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="generateTokens"
              onPress={this.generateTokens}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="localKeys"
              onPress={this.localKeys}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="localKey"
              onPress={this.localKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="currentKey"
              onPress={this.currentKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="syncVehicleDataWithSuccess"
              onPress={this.syncVehicleDataWithSuccess}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="activateLogging"
              onPress={this.activateLogging}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="localKeyWithCompletionBlock"
              onPress={this.localKeyWithCompletionBlock}
            />
          </View>
        </View>
      </ScrollView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  buttonbg: {
    backgroundColor: 'darkblue',
    margin: 8,
    alignSelf: 'stretch',
  },
  title: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
    marginTop: 40,
  }
});
