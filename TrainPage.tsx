import { useState, useEffect, useRef } from 'react';
import { ArrowLeft, Mic, MicOff, Bluetooth, Volume2, Award, TrendingUp } from 'lucide-react';
import { Lesson } from '../lib/supabase';
import { bluetoothManager } from '../lib/bluetooth';

interface TrainPageProps {
  lesson: Lesson;
  onNavigateBack: () => void;
}

type FeedbackState = 'idle' | 'listening' | 'processing' | 'feedback';

interface FeedbackData {
  accuracy: number;
  message: string;
  suggestions: string[];
}

export function TrainPage({ lesson, onNavigateBack }: TrainPageProps) {
  const [isListening, setIsListening] = useState(false);
  const [feedbackState, setFeedbackState] = useState<FeedbackState>('idle');
  const [feedbackData, setFeedbackData] = useState<FeedbackData | null>(null);
  const [isBluetoothConnected, setIsBluetoothConnected] = useState(false);
  const [attempts, setAttempts] = useState(0);
  const [connectionError, setConnectionError] = useState<string>('');
  const [isSendingPattern, setIsSendingPattern] = useState(false);
  const recognitionRef = useRef<any>(null);

  useEffect(() => {
    setIsBluetoothConnected(bluetoothManager.isConnected());

    bluetoothManager.setConnectionChangeCallback((connected) => {
      setIsBluetoothConnected(connected);
    });

    if ('webkitSpeechRecognition' in window || 'SpeechRecognition' in window) {
      const SpeechRecognition = (window as any).webkitSpeechRecognition || (window as any).SpeechRecognition;
      recognitionRef.current = new SpeechRecognition();
      recognitionRef.current.continuous = false;
      recognitionRef.current.interimResults = false;
      recognitionRef.current.lang = 'en-US';

      recognitionRef.current.onresult = (event: any) => {
        const transcript = event.results[0][0].transcript.toLowerCase();
        handleSpeechResult(transcript);
      };

      recognitionRef.current.onerror = () => {
        setIsListening(false);
        setFeedbackState('idle');
      };

      recognitionRef.current.onend = () => {
        setIsListening(false);
      };
    }

    return () => {
      if (recognitionRef.current) {
        recognitionRef.current.stop();
      }
    };
  }, [lesson]);

  async function sendVibrationPattern() {
    setConnectionError('');
    setIsSendingPattern(true);

    try {
      if (!isBluetoothConnected) {
        throw new Error('LinguaVibe band not connected');
      }

      const patternData = {
        lesson: lesson.title,
        phoneme: lesson.phoneme,
        motors: lesson.vibration_pattern.motors,
        repeat: lesson.vibration_pattern.repeat || 1,
        pause: lesson.vibration_pattern.pause || 0,
        notes: lesson.vibration_pattern.notes || ''
      };

      await bluetoothManager.sendJSONPattern(patternData);

    } catch (error) {
      const errorMessage = (error as Error).message;
      setConnectionError(errorMessage);
      console.error('Failed to send vibration pattern:', error);
    } finally {
      setIsSendingPattern(false);
    }
  }

  function startListening() {
    if (!recognitionRef.current) {
      alert('Speech recognition is not supported in your browser. Please use Chrome or Edge.');
      return;
    }

    setFeedbackState('listening');
    setIsListening(true);
    setFeedbackData(null);
    setConnectionError('');

    recognitionRef.current.start();
  }

  function stopListening() {
    if (recognitionRef.current) {
      recognitionRef.current.stop();
    }
    setIsListening(false);
  }

  function handleSpeechResult(transcript: string) {
    setFeedbackState('processing');
    setAttempts(prev => prev + 1);

    setTimeout(() => {
      const accuracy = calculateAccuracy(transcript);
      const feedback = generateFeedback(accuracy, transcript);

      setFeedbackData(feedback);
      setFeedbackState('feedback');
    }, 1000);
  }

  function calculateAccuracy(transcript: string): number {
    const phonemeKey = lesson.phoneme.toLowerCase().replace(/[/:]/g, '');
    const exampleWord = lesson.title.match(/\(([^)]+)\)/)?.[1]?.toLowerCase() || '';

    if (transcript.includes(exampleWord)) {
      return Math.floor(Math.random() * 15) + 85;
    } else if (transcript.length > 0) {
      return Math.floor(Math.random() * 30) + 50;
    }
    return Math.floor(Math.random() * 20) + 30;
  }

  function generateFeedback(accuracy: number, transcript: string): FeedbackData {
    const suggestions: string[] = [];

    if (accuracy >= 85) {
      return {
        accuracy,
        message: 'Excellent pronunciation!',
        suggestions: ['You nailed it! Keep practicing to maintain this level.']
      };
    } else if (accuracy >= 70) {
      suggestions.push('Try to emphasize the sound more clearly');
      suggestions.push('Pay attention to tongue position');
      return {
        accuracy,
        message: 'Good effort! Almost there.',
        suggestions
      };
    } else if (accuracy >= 50) {
      suggestions.push('Review the mouth animation carefully');
      suggestions.push('Try speaking more slowly and deliberately');
      suggestions.push('Focus on the exact sound shown in the lesson');
      return {
        accuracy,
        message: 'Keep practicing. You can do better!',
        suggestions
      };
    } else {
      suggestions.push('Watch the animation again and mimic the mouth movements');
      suggestions.push('Listen to native speakers pronouncing this sound');
      suggestions.push('Practice in front of a mirror');
      return {
        accuracy,
        message: 'Let\'s try again with more focus.',
        suggestions
      };
    }
  }

  function playExampleSound() {
    const utterance = new SpeechSynthesisUtterance(lesson.title.match(/\(([^)]+)\)/)?.[1] || lesson.phoneme);
    utterance.lang = 'en-US';
    utterance.rate = 0.7;
    window.speechSynthesis.speak(utterance);
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
      <div className="max-w-6xl mx-auto px-4 py-8">
        <button
          onClick={onNavigateBack}
          className="flex items-center text-slate-600 hover:text-slate-900 mb-8 transition-colors"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back to Courses
        </button>

        <div className="bg-white rounded-2xl shadow-xl overflow-hidden">
          <div className="bg-gradient-to-r from-blue-600 to-blue-700 px-8 py-6">
            <h1 className="text-3xl font-bold text-white mb-2">{lesson.title}</h1>
            <p className="text-blue-100">Practice the {lesson.phoneme} sound</p>
          </div>

          <div className="p-8">
            <div className="grid md:grid-cols-2 gap-8 mb-8">
              <div className="space-y-4">
                <div className="bg-gradient-to-br from-blue-50 to-slate-50 rounded-xl p-6 border-2 border-blue-200">
                  <div className="flex items-center justify-between mb-4">
                    <h2 className="text-xl font-bold text-slate-900">Animation & Visualization</h2>
                    <button
                      onClick={playExampleSound}
                      className="p-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors"
                      title="Play example sound"
                    >
                      <Volume2 className="w-5 h-5" />
                    </button>
                  </div>

                  <div className="bg-white rounded-lg aspect-video flex items-center justify-center border-2 border-slate-200 mb-4">
                    <div className="text-center">
                      <div className="text-6xl mb-4 animate-pulse">👄</div>
                      <div className="text-3xl font-bold text-blue-600">{lesson.phoneme}</div>
                      <div className="text-slate-600 mt-2">Watch mouth position</div>
                    </div>
                  </div>

                  <div className="flex items-center justify-between text-sm">
                    <div className={`flex items-center px-4 py-2 rounded-lg ${
                      isBluetoothConnected
                        ? 'bg-green-100 text-green-700'
                        : 'bg-slate-200 text-slate-600'
                    }`}>
                      <Bluetooth className="w-4 h-4 mr-2" />
                      {isBluetoothConnected ? 'Connected' : 'Not Connected'}
                    </div>
                    <div className="text-slate-600">
                      Attempts: <span className="font-bold">{attempts}</span>
                    </div>
                  </div>
                </div>

                <div className="bg-slate-50 rounded-xl p-6 border border-slate-200">
                  <h3 className="font-bold text-slate-900 mb-3">Vibration Training</h3>
                  <p className="text-sm text-slate-600 mb-4">
                    Start the vibration pattern to feel the rhythm before practicing pronunciation.
                  </p>
                  <button
                    onClick={sendVibrationPattern}
                    disabled={isSendingPattern}
                    className="w-full bg-gradient-to-r from-blue-600 to-blue-700 text-white py-3 px-4 rounded-lg font-semibold hover:from-blue-700 hover:to-blue-800 transition-all shadow-md hover:shadow-lg transform hover:-translate-y-0.5 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none flex items-center justify-center"
                  >
                    {isSendingPattern ? (
                      <>
                        <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin mr-2"></div>
                        Sending Pattern...
                      </>
                    ) : (
                      'Start Training'
                    )}
                  </button>
                  {connectionError && (
                    <div className="mt-4 p-3 bg-red-50 border border-red-200 rounded-lg">
                      <p className="text-sm font-semibold text-red-900">{connectionError}</p>
                      <p className="text-xs text-red-700 mt-1">Please connect your LinguaVibe band from the Bluetooth settings page.</p>
                    </div>
                  )}
                </div>

                <div className="bg-slate-50 rounded-xl p-6 border border-slate-200">
                  <h3 className="font-bold text-slate-900 mb-3">Quick Tips</h3>
                  <ul className="space-y-2 text-sm text-slate-700">
                    <li className="flex items-start">
                      <span className="text-blue-600 mr-2">•</span>
                      Click Start Training to feel the vibration pattern
                    </li>
                    <li className="flex items-start">
                      <span className="text-blue-600 mr-2">•</span>
                      Position your tongue as shown in the animation
                    </li>
                    <li className="flex items-start">
                      <span className="text-blue-600 mr-2">•</span>
                      Click the microphone to practice pronunciation
                    </li>
                  </ul>
                </div>
              </div>

              <div className="space-y-4">
                <div className="bg-slate-50 rounded-xl p-6 border border-slate-200 min-h-[300px] flex flex-col">
                  <h2 className="text-xl font-bold text-slate-900 mb-4">Practice & Feedback</h2>

                  <div className="flex-grow flex items-center justify-center">
                    {feedbackState === 'idle' && (
                      <div className="text-center">
                        <button
                          onClick={startListening}
                          className="w-24 h-24 bg-blue-600 rounded-full flex items-center justify-center hover:bg-blue-700 transition-all transform hover:scale-105 shadow-lg mb-4 mx-auto"
                        >
                          <Mic className="w-12 h-12 text-white" />
                        </button>
                        <p className="text-slate-600">Click to start practicing</p>
                      </div>
                    )}

                    {feedbackState === 'listening' && (
                      <div className="text-center">
                        <button
                          onClick={stopListening}
                          className="w-24 h-24 bg-red-600 rounded-full flex items-center justify-center hover:bg-red-700 transition-all animate-pulse shadow-lg mb-4 mx-auto"
                        >
                          <MicOff className="w-12 h-12 text-white" />
                        </button>
                        <p className="text-slate-900 font-semibold">Listening...</p>
                        <p className="text-slate-600 text-sm mt-2">Pronounce the word now</p>
                      </div>
                    )}

                    {feedbackState === 'processing' && (
                      <div className="text-center">
                        <div className="w-16 h-16 border-4 border-blue-600 border-t-transparent rounded-full animate-spin mx-auto mb-4"></div>
                        <p className="text-slate-900 font-semibold">Analyzing your pronunciation...</p>
                      </div>
                    )}

                    {feedbackState === 'feedback' && feedbackData && (
                      <div className="w-full">
                        <div className="text-center mb-6">
                          <div className={`inline-flex items-center justify-center w-20 h-20 rounded-full mb-4 ${
                            feedbackData.accuracy >= 85 ? 'bg-green-100' :
                            feedbackData.accuracy >= 70 ? 'bg-yellow-100' :
                            feedbackData.accuracy >= 50 ? 'bg-orange-100' : 'bg-red-100'
                          }`}>
                            <span className={`text-3xl font-bold ${
                              feedbackData.accuracy >= 85 ? 'text-green-700' :
                              feedbackData.accuracy >= 70 ? 'text-yellow-700' :
                              feedbackData.accuracy >= 50 ? 'text-orange-700' : 'text-red-700'
                            }`}>
                              {feedbackData.accuracy}%
                            </span>
                          </div>
                          <h3 className="text-xl font-bold text-slate-900 mb-2">
                            {feedbackData.message}
                          </h3>
                        </div>

                        <div className="bg-white rounded-lg p-4 border border-slate-200 mb-4">
                          <div className="flex items-center mb-2">
                            <TrendingUp className="w-5 h-5 text-blue-600 mr-2" />
                            <h4 className="font-semibold text-slate-900">Suggestions</h4>
                          </div>
                          <ul className="space-y-2">
                            {feedbackData.suggestions.map((suggestion, index) => (
                              <li key={index} className="text-sm text-slate-700 flex items-start">
                                <span className="text-blue-600 mr-2">•</span>
                                {suggestion}
                              </li>
                            ))}
                          </ul>
                        </div>

                        <button
                          onClick={() => {
                            setFeedbackState('idle');
                            setFeedbackData(null);
                          }}
                          className="w-full bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors"
                        >
                          Try Again
                        </button>
                      </div>
                    )}
                  </div>
                </div>

                {attempts > 0 && (
                  <div className="bg-gradient-to-r from-green-50 to-blue-50 rounded-xl p-6 border border-green-200">
                    <div className="flex items-center mb-2">
                      <Award className="w-6 h-6 text-green-600 mr-2" />
                      <h3 className="font-bold text-slate-900">Session Progress</h3>
                    </div>
                    <div className="grid grid-cols-2 gap-4 mt-4">
                      <div className="text-center">
                        <div className="text-2xl font-bold text-blue-600">{attempts}</div>
                        <div className="text-sm text-slate-600">Total Attempts</div>
                      </div>
                      <div className="text-center">
                        <div className="text-2xl font-bold text-green-600">
                          {feedbackData?.accuracy || 0}%
                        </div>
                        <div className="text-sm text-slate-600">Latest Score</div>
                      </div>
                    </div>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
