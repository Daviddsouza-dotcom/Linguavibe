export interface BluetoothDeviceInfo {
  id: string;
  name: string;
  connected: boolean;
  device?: BluetoothDevice;
  characteristic?: BluetoothRemoteGATTCharacteristic;
}

const SERVICE_UUID = '4fafc201-1fb5-459e-8fcc-c5c9c331914b';
const CHARACTERISTIC_UUID = 'beb5483e-36e1-4688-b7f5-ea07361b26a8';

export class BluetoothManager {
  private device: BluetoothDevice | null = null;
  private characteristic: BluetoothRemoteGATTCharacteristic | null = null;
  private onConnectionChange: ((connected: boolean) => void) | null = null;

  isSupported(): boolean {
    return 'bluetooth' in navigator;
  }

  setConnectionChangeCallback(callback: (connected: boolean) => void) {
    this.onConnectionChange = callback;
  }

  async scan(): Promise<BluetoothDevice> {
    if (!this.isSupported()) {
      throw new Error('Web Bluetooth API is not supported in this browser');
    }

    try {
      const device = await navigator.bluetooth.requestDevice({
        filters: [
          { namePrefix: 'ESP32' },
          { namePrefix: 'ESP' }
        ],
        optionalServices: [SERVICE_UUID]
      });

      return device;
    } catch (error) {
      throw new Error(`Failed to scan for devices: ${(error as Error).message}`);
    }
  }

  async connect(device: BluetoothDevice): Promise<boolean> {
    try {
      if (!device.gatt) {
        throw new Error('GATT not available on device');
      }

      const server = await device.gatt.connect();
      const service = await server.getPrimaryService(SERVICE_UUID);
      const characteristic = await service.getCharacteristic(CHARACTERISTIC_UUID);

      this.device = device;
      this.characteristic = characteristic;

      device.addEventListener('gattserverdisconnected', () => {
        this.handleDisconnection();
      });

      if (this.onConnectionChange) {
        this.onConnectionChange(true);
      }

      return true;
    } catch (error) {
      throw new Error(`Failed to connect: ${(error as Error).message}`);
    }
  }

  async disconnect(): Promise<void> {
    if (this.device?.gatt?.connected) {
      this.device.gatt.disconnect();
    }
    this.handleDisconnection();
  }

  private handleDisconnection() {
    this.device = null;
    this.characteristic = null;
    if (this.onConnectionChange) {
      this.onConnectionChange(false);
    }
  }

  isConnected(): boolean {
    return this.device?.gatt?.connected || false;
  }

  getDevice(): BluetoothDevice | null {
    return this.device;
  }

  getCharacteristic(): BluetoothRemoteGATTCharacteristic | null {
    return this.characteristic;
  }

  async sendVibrationPattern(pattern: number[], intensity: number): Promise<void> {
    if (!this.characteristic) {
      throw new Error('No characteristic available. Please connect to a device first.');
    }

    try {
      const data = new Uint8Array([intensity, ...pattern.slice(0, 5)]);
      await this.characteristic.writeValue(data);
    } catch (error) {
      throw new Error(`Failed to send vibration pattern: ${(error as Error).message}`);
    }
  }

  async send4MotorPattern(motors: Array<{M1: number, M2: number, M3: number, M4: number, duration: number}>): Promise<void> {
    if (!this.characteristic) {
      throw new Error('LinguaVibe band not connected');
    }

    try {
      for (const motor of motors) {
        const data = new Uint8Array([motor.M1, motor.M2, motor.M3, motor.M4, motor.duration & 0xFF, (motor.duration >> 8) & 0xFF]);
        await this.characteristic.writeValue(data);
        await new Promise(resolve => setTimeout(resolve, motor.duration));
      }
    } catch (error) {
      throw new Error(`Failed to send motor pattern: ${(error as Error).message}`);
    }
  }

  async sendJSONPattern(pattern: any): Promise<void> {
    if (!this.characteristic) {
      throw new Error('LinguaVibe band not connected');
    }

    try {
      const jsonString = JSON.stringify(pattern);
      const encoder = new TextEncoder();
      const data = encoder.encode(jsonString);

      const maxChunkSize = 512;
      for (let i = 0; i < data.length; i += maxChunkSize) {
        const chunk = data.slice(i, Math.min(i + maxChunkSize, data.length));
        await this.characteristic.writeValue(chunk);
        await new Promise(resolve => setTimeout(resolve, 50));
      }
    } catch (error) {
      throw new Error(`Failed to send JSON pattern: ${(error as Error).message}`);
    }
  }

  async testVibration(): Promise<void> {
    const testPattern = [{M1: 200, M2: 100, M3: 200, M4: 100, duration: 200}];
    await this.send4MotorPattern(testPattern);
  }
}

export const bluetoothManager = new BluetoothManager();
