/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  NativeModules
} from 'react-native';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = { something: '' };
  }

  async printname() {
    try {
      const something1 = await NativeModules.OTABridge.printSomething('something');
      this.setState(() => ({
        something: something1
      }));
    } catch (e) {
      console.log(e);
    }
  }

  async openSessionWithToken() {
    try {
      this.result = await NativeModules.OTABridge.openSessionWithToken('VCpCTVlS3P535Y7ZpGjE0YGJ91dfgqRA');
      console.log(this.result);
    } catch (e) {
      console.log(`Erro do OTA ${e}`);
    }
  }

  createKey() {
    this.otaKeyRequest = {
      otaId: '1',
      extId: '1',
      beginDate: '01-03-2019',
      endDate: '01-03-2019',
      vehicleId: '1',
      vehicleExtId: '1',
      enableNow: true,
      tokenAmount: '16',
      singleShotSecurity: true,
      security: 'token'
    };

    this.otaKeyPublic = [{
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
        vehicleData: {
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
        }
      },
      lastVehicleSynthesis: {
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
      }
    },
    {
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
        vehicleData: {
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
        }
      },
      lastVehicleSynthesis: {
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
      }
    }];

    try {
      const result = NativeModules.OTABridge.keysWithSuccess(JSON.stringify(this.otaKeyPublic));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  render() {
    this.printname();
    this.createKey();
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>
        <Text style={styles.instructions}>{this.state.something}</Text>
      </View>
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
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
