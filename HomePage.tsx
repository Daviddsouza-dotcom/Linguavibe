import { BookOpen, Target, Waves, Facebook, Twitter, Instagram, Youtube, Bluetooth } from 'lucide-react';

interface HomePageProps {
  onNavigateToCourses: () => void;
  onNavigateToBluetooth: () => void;
}

export function HomePage({ onNavigateToCourses, onNavigateToBluetooth }: HomePageProps) {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
      <div className="max-w-6xl mx-auto px-4 py-8">
        <header className="text-center mb-12 pt-8">
          <div className="flex items-center justify-center mb-6">
            <img
              src="/image.png"
              alt="LinguaVibe Logo"
              className="w-32 h-32 md:w-40 md:h-40 object-contain"
            />
          </div>
          <h1 className="text-5xl md:text-6xl font-bold text-slate-900 mb-3">LinguaVibe</h1>
          <p className="text-xl text-slate-600 font-medium">
            Feel the rhythm of language, master every sound
          </p>
        </header>

        <div className="grid md:grid-cols-2 gap-6 mb-16">
          <section className="bg-gradient-to-r from-blue-600 to-blue-700 rounded-2xl shadow-xl p-8 text-center">
            <h2 className="text-2xl font-bold text-white mb-3">Ready to Begin?</h2>
            <p className="text-blue-100 mb-6">
              Start mastering phonemes with our courses
            </p>
            <button
              onClick={onNavigateToCourses}
              className="w-full bg-white text-blue-600 px-6 py-3 rounded-lg font-semibold hover:bg-blue-50 transition-colors shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-transform"
            >
              Explore Courses
            </button>
          </section>

          <section className="bg-gradient-to-r from-slate-700 to-slate-800 rounded-2xl shadow-xl p-8 text-center">
            <div className="flex items-center justify-center mb-3">
              <Bluetooth className="w-6 h-6 text-white mr-2" />
              <h2 className="text-2xl font-bold text-white">Connect Device</h2>
            </div>
            <p className="text-slate-300 mb-6">
              Set up your ESP32 for haptic feedback
            </p>
            <button
              onClick={onNavigateToBluetooth}
              className="w-full bg-white text-slate-700 px-6 py-3 rounded-lg font-semibold hover:bg-slate-100 transition-colors shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-transform"
            >
              Bluetooth Settings
            </button>
          </section>
        </div>

        <section className="bg-white rounded-2xl shadow-lg p-12 mb-12">
          <h2 className="text-4xl font-bold text-slate-900 mb-6">Welcome to LinguaVibe</h2>
          <p className="text-lg text-slate-700 leading-relaxed mb-6">
            Experience language learning like never before. LinguaVibe combines cutting-edge
            speech recognition, immersive animations, and haptic feedback to help you master
            pronunciation with precision and confidence.
          </p>
          <p className="text-lg text-slate-700 leading-relaxed">
            Whether you're a beginner or looking to refine your accent, our interactive phoneme
            training system provides real-time feedback and personalized insights to accelerate
            your learning journey.
          </p>
        </section>

        <section className="grid md:grid-cols-3 gap-8 mb-12">
          <div className="bg-white rounded-xl shadow-md p-8 hover:shadow-xl transition-shadow">
            <div className="bg-blue-100 w-14 h-14 rounded-lg flex items-center justify-center mb-4">
              <BookOpen className="w-8 h-8 text-blue-600" />
            </div>
            <h3 className="text-xl font-bold text-slate-900 mb-3">Interactive Lessons</h3>
            <p className="text-slate-600 leading-relaxed">
              Engage with dynamic animations that show you exactly how to form each sound,
              making complex phonemes easy to understand and replicate.
            </p>
          </div>

          <div className="bg-white rounded-xl shadow-md p-8 hover:shadow-xl transition-shadow">
            <div className="bg-green-100 w-14 h-14 rounded-lg flex items-center justify-center mb-4">
              <Target className="w-8 h-8 text-green-600" />
            </div>
            <h3 className="text-xl font-bold text-slate-900 mb-3">Real-Time Feedback</h3>
            <p className="text-slate-600 leading-relaxed">
              Practice pronunciation with instant AI-powered feedback. Get detailed insights
              and accuracy scores to track your progress and improve rapidly.
            </p>
          </div>

          <div className="bg-white rounded-xl shadow-md p-8 hover:shadow-xl transition-shadow">
            <div className="bg-orange-100 w-14 h-14 rounded-lg flex items-center justify-center mb-4">
              <Waves className="w-8 h-8 text-orange-600" />
            </div>
            <h3 className="text-xl font-bold text-slate-900 mb-3">Haptic Learning</h3>
            <p className="text-slate-600 leading-relaxed">
              Experience unique vibration patterns through Bluetooth-connected devices that
              help you feel the rhythm and stress of each phoneme.
            </p>
          </div>
        </section>

        <footer className="border-t border-slate-200 pt-8">
          <div className="flex justify-center space-x-6 mb-6">
            <a
              href="#"
              className="w-12 h-12 bg-slate-200 rounded-full flex items-center justify-center hover:bg-blue-600 hover:text-white transition-colors"
              aria-label="Facebook"
            >
              <Facebook className="w-5 h-5" />
            </a>
            <a
              href="#"
              className="w-12 h-12 bg-slate-200 rounded-full flex items-center justify-center hover:bg-blue-400 hover:text-white transition-colors"
              aria-label="Twitter"
            >
              <Twitter className="w-5 h-5" />
            </a>
            <a
              href="#"
              className="w-12 h-12 bg-slate-200 rounded-full flex items-center justify-center hover:bg-pink-600 hover:text-white transition-colors"
              aria-label="Instagram"
            >
              <Instagram className="w-5 h-5" />
            </a>
            <a
              href="#"
              className="w-12 h-12 bg-slate-200 rounded-full flex items-center justify-center hover:bg-red-600 hover:text-white transition-colors"
              aria-label="YouTube"
            >
              <Youtube className="w-5 h-5" />
            </a>
          </div>
          <p className="text-center text-slate-500 text-sm">
            © 2025 LinguaVibe. All rights reserved.
          </p>
        </footer>
      </div>
    </div>
  );
}
