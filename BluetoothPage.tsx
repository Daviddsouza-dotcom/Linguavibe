import { useState, useEffect } from 'react';
import {
  ArrowLeft,
  Bluetooth,
  BluetoothConnected,
  BluetoothSearching,
  CheckCircle2,
  XCircle,
  Zap,
  AlertCircle,
  RefreshCw
} from 'lucide-react';
import { bluetoothManager } from '../lib/bluetooth';

interface BluetoothPageProps {
  onNavigateBack: () => void;
}

type ConnectionStatus = 'disconnected' | 'scanning' | 'connecting' | 'connected';

export function BluetoothPage({ onNavigateBack }: BluetoothPageProps) {
  const [status, setStatus] = useState<ConnectionStatus>('disconnected');
  const [deviceName, setDeviceName] = useState<string>('');
  const [error, setError] = useState<string>('');
  const [isSupported, setIsSupported] = useState(true);
  const [testingVibration, setTestingVibration] = useState(false);

  useEffect(() => {
    setIsSupported(bluetoothManager.isSupported());

    bluetoothManager.setConnectionChangeCallback((connected) => {
      if (connected) {
        setStatus('connected');
      } else {
        setStatus('disconnected');
        setDeviceName('');
      }
    });

    if (bluetoothManager.isConnected()) {
      const device = bluetoothManager.getDevice();
      if (device) {
        setStatus('connected');
        setDeviceName(device.name || 'Unknown Device');
      }
    }
  }, []);

  async function handleScan() {
    setError('');
    setStatus('scanning');

    try {
      const device = await bluetoothManager.scan();
      setDeviceName(device.name || 'Unknown Device');
      setStatus('connecting');

      await bluetoothManager.connect(device);
      setStatus('connected');
    } catch (err) {
      const errorMessage = (err as Error).message;
      setError(errorMessage);
      setStatus('disconnected');
    }
  }

  async function handleDisconnect() {
    try {
      await bluetoothManager.disconnect();
      setStatus('disconnected');
      setDeviceName('');
      setError('');
    } catch (err) {
      setError((err as Error).message);
    }
  }

  async function handleTestVibration() {
    setTestingVibration(true);
    setError('');

    try {
      await bluetoothManager.testVibration();
      setTimeout(() => setTestingVibration(false), 1000);
    } catch (err) {
      setError((err as Error).message);
      setTestingVibration(false);
    }
  }

  if (!isSupported) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
        <div className="max-w-4xl mx-auto px-4 py-8">
          <button
            onClick={onNavigateBack}
            className="flex items-center text-slate-600 hover:text-slate-900 mb-8 transition-colors"
          >
            <ArrowLeft className="w-5 h-5 mr-2" />
            Back
          </button>

          <div className="bg-white rounded-2xl shadow-xl p-12 text-center">
            <XCircle className="w-16 h-16 text-red-600 mx-auto mb-4" />
            <h2 className="text-2xl font-bold text-slate-900 mb-4">
              Bluetooth Not Supported
            </h2>
            <p className="text-slate-600 mb-4">
              Your browser does not support Web Bluetooth API.
            </p>
            <p className="text-slate-600">
              Please use Google Chrome, Microsoft Edge, or Opera on a desktop or Android device.
            </p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
      <div className="max-w-4xl mx-auto px-4 py-8">
        <button
          onClick={onNavigateBack}
          className="flex items-center text-slate-600 hover:text-slate-900 mb-8 transition-colors"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back
        </button>

        <header className="mb-8">
          <div className="flex items-center mb-4">
            <Bluetooth className="w-10 h-10 text-blue-600 mr-4" />
            <h1 className="text-4xl font-bold text-slate-900">Bluetooth Connection</h1>
          </div>
          <p className="text-lg text-slate-600">
            Connect your ESP32 device to enable haptic feedback during lessons
          </p>
        </header>

        <div className="bg-white rounded-2xl shadow-xl overflow-hidden mb-6">
          <div className="bg-gradient-to-r from-blue-600 to-blue-700 px-8 py-6">
            <div className="flex items-center justify-between">
              <div>
                <h2 className="text-2xl font-bold text-white mb-1">Device Status</h2>
                <p className="text-blue-100">
                  {status === 'connected' && 'Connected and ready'}
                  {status === 'disconnected' && 'No device connected'}
                  {status === 'scanning' && 'Searching for devices...'}
                  {status === 'connecting' && 'Establishing connection...'}
                </p>
              </div>
              <div className="bg-white/20 rounded-full p-4">
                {status === 'connected' && (
                  <BluetoothConnected className="w-8 h-8 text-white" />
                )}
                {status === 'disconnected' && (
                  <Bluetooth className="w-8 h-8 text-white" />
                )}
                {(status === 'scanning' || status === 'connecting') && (
                  <BluetoothSearching className="w-8 h-8 text-white animate-pulse" />
                )}
              </div>
            </div>
          </div>

          <div className="p-8">
            {status === 'connected' && (
              <div className="space-y-6">
                <div className="bg-green-50 border-2 border-green-200 rounded-xl p-6">
                  <div className="flex items-center mb-4">
                    <CheckCircle2 className="w-6 h-6 text-green-600 mr-3" />
                    <div>
                      <h3 className="text-lg font-bold text-slate-900">Connected Device</h3>
                      <p className="text-slate-600">{deviceName}</p>
                    </div>
                  </div>

                  <div className="grid grid-cols-2 gap-4 mt-4">
                    <div className="bg-white rounded-lg p-4 border border-green-200">
                      <div className="text-sm text-slate-600 mb-1">Status</div>
                      <div className="text-lg font-bold text-green-600">Active</div>
                    </div>
                    <div className="bg-white rounded-lg p-4 border border-green-200">
                      <div className="text-sm text-slate-600 mb-1">Signal</div>
                      <div className="text-lg font-bold text-green-600">Strong</div>
                    </div>
                  </div>
                </div>

                <div className="space-y-3">
                  <button
                    onClick={handleTestVibration}
                    disabled={testingVibration}
                    className="w-full bg-blue-600 text-white py-4 rounded-lg font-semibold hover:bg-blue-700 transition-colors flex items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    {testingVibration ? (
                      <>
                        <RefreshCw className="w-5 h-5 mr-2 animate-spin" />
                        Testing Vibration...
                      </>
                    ) : (
                      <>
                        <Zap className="w-5 h-5 mr-2" />
                        Test Vibration
                      </>
                    )}
                  </button>

                  <button
                    onClick={handleDisconnect}
                    className="w-full bg-slate-200 text-slate-700 py-4 rounded-lg font-semibold hover:bg-slate-300 transition-colors"
                  >
                    Disconnect Device
                  </button>
                </div>
              </div>
            )}

            {status === 'disconnected' && (
              <div className="space-y-6">
                <div className="bg-slate-50 border-2 border-slate-200 rounded-xl p-6">
                  <h3 className="text-lg font-bold text-slate-900 mb-4">How to Connect</h3>
                  <ol className="space-y-3">
                    <li className="flex items-start">
                      <span className="flex items-center justify-center w-6 h-6 rounded-full bg-blue-600 text-white text-sm font-bold mr-3 flex-shrink-0">
                        1
                      </span>
                      <span className="text-slate-700">
                        Make sure your ESP32 device is powered on and Bluetooth is enabled
                      </span>
                    </li>
                    <li className="flex items-start">
                      <span className="flex items-center justify-center w-6 h-6 rounded-full bg-blue-600 text-white text-sm font-bold mr-3 flex-shrink-0">
                        2
                      </span>
                      <span className="text-slate-700">
                        Click the "Scan for Devices" button below
                      </span>
                    </li>
                    <li className="flex items-start">
                      <span className="flex items-center justify-center w-6 h-6 rounded-full bg-blue-600 text-white text-sm font-bold mr-3 flex-shrink-0">
                        3
                      </span>
                      <span className="text-slate-700">
                        Select your ESP32 device from the list that appears
                      </span>
                    </li>
                    <li className="flex items-start">
                      <span className="flex items-center justify-center w-6 h-6 rounded-full bg-blue-600 text-white text-sm font-bold mr-3 flex-shrink-0">
                        4
                      </span>
                      <span className="text-slate-700">
                        Once connected, test the vibration to ensure it's working
                      </span>
                    </li>
                  </ol>
                </div>

                <button
                  onClick={handleScan}
                  className="w-full bg-blue-600 text-white py-4 rounded-lg font-semibold hover:bg-blue-700 transition-colors flex items-center justify-center shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-transform"
                >
                  <BluetoothSearching className="w-5 h-5 mr-2" />
                  Scan for Devices
                </button>
              </div>
            )}

            {(status === 'scanning' || status === 'connecting') && (
              <div className="text-center py-12">
                <div className="w-16 h-16 border-4 border-blue-600 border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
                <p className="text-slate-600 font-semibold">
                  {status === 'scanning' && 'Looking for ESP32 devices...'}
                  {status === 'connecting' && `Connecting to ${deviceName}...`}
                </p>
              </div>
            )}

            {error && (
              <div className="mt-6 bg-red-50 border-2 border-red-200 rounded-xl p-4 flex items-start">
                <AlertCircle className="w-5 h-5 text-red-600 mr-3 flex-shrink-0 mt-0.5" />
                <div>
                  <h4 className="font-semibold text-red-900 mb-1">Connection Error</h4>
                  <p className="text-red-700 text-sm">{error}</p>
                </div>
              </div>
            )}
          </div>
        </div>

        <div className="bg-blue-50 border border-blue-200 rounded-xl p-6">
          <div className="flex items-start">
            <AlertCircle className="w-5 h-5 text-blue-600 mr-3 flex-shrink-0 mt-0.5" />
            <div className="text-sm text-blue-900">
              <p className="font-semibold mb-2">Requirements</p>
              <ul className="space-y-1 text-blue-800">
                <li>• Your ESP32 must be running compatible firmware with the correct UUIDs</li>
                <li>• Use Chrome, Edge, or Opera browser (Firefox and Safari don't support Web Bluetooth)</li>
                <li>• Bluetooth must be enabled on your computer or device</li>
                <li>• The ESP32 device name should start with "ESP32" or "ESP"</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
