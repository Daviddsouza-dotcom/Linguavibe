import { useState } from 'react';
import { HomePage } from './components/HomePage';
import { CoursePage } from './components/CoursePage';
import { TrainPage } from './components/TrainPage';
import { BluetoothPage } from './components/BluetoothPage';
import { Lesson } from './lib/supabase';

type Page = 'home' | 'courses' | 'train' | 'bluetooth';

function App() {
  const [currentPage, setCurrentPage] = useState<Page>('home');
  const [selectedLesson, setSelectedLesson] = useState<Lesson | null>(null);

  function handleSelectLesson(lesson: Lesson) {
    setSelectedLesson(lesson);
    setCurrentPage('train');
  }

  return (
    <>
      {currentPage === 'home' && (
        <HomePage
          onNavigateToCourses={() => setCurrentPage('courses')}
          onNavigateToBluetooth={() => setCurrentPage('bluetooth')}
        />
      )}
      {currentPage === 'courses' && (
        <CoursePage
          onNavigateHome={() => setCurrentPage('home')}
          onSelectLesson={handleSelectLesson}
        />
      )}
      {currentPage === 'train' && selectedLesson && (
        <TrainPage
          lesson={selectedLesson}
          onNavigateBack={() => setCurrentPage('courses')}
        />
      )}
      {currentPage === 'bluetooth' && (
        <BluetoothPage
          onNavigateBack={() => setCurrentPage('home')}
        />
      )}
    </>
  );
}

export default App;
