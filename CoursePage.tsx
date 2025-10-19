import { useState, useEffect } from 'react';
import { ChevronDown, ChevronRight, ArrowLeft, Languages } from 'lucide-react';
import { supabase, Language, Course, Lesson } from '../lib/supabase';

interface CoursePageProps {
  onNavigateHome: () => void;
  onSelectLesson: (lesson: Lesson) => void;
}

export function CoursePage({ onNavigateHome, onSelectLesson }: CoursePageProps) {
  const [languages, setLanguages] = useState<Language[]>([]);
  const [selectedLanguage, setSelectedLanguage] = useState<Language | null>(null);
  const [courses, setCourses] = useState<Course[]>([]);
  const [lessons, setLessons] = useState<Record<string, Lesson[]>>({});
  const [expandedCourse, setExpandedCourse] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadLanguages();
  }, []);

  useEffect(() => {
    if (selectedLanguage) {
      loadCourses(selectedLanguage.id);
    }
  }, [selectedLanguage]);

  async function loadLanguages() {
    try {
      const { data, error } = await supabase
        .from('languages')
        .select('*')
        .eq('is_active', true)
        .order('name');

      if (error) throw error;

      setLanguages(data || []);
      if (data && data.length > 0) {
        setSelectedLanguage(data[0]);
      }
    } catch (error) {
      console.error('Error loading languages:', error);
    } finally {
      setLoading(false);
    }
  }

  async function loadCourses(languageId: string) {
    try {
      const { data, error } = await supabase
        .from('courses')
        .select('*')
        .eq('language_id', languageId)
        .order('order_index');

      if (error) throw error;
      setCourses(data || []);
    } catch (error) {
      console.error('Error loading courses:', error);
    }
  }

  async function loadLessons(courseId: string) {
    if (lessons[courseId]) {
      return;
    }

    try {
      const { data, error } = await supabase
        .from('lessons')
        .select('*')
        .eq('course_id', courseId)
        .order('order_index');

      if (error) throw error;
      setLessons(prev => ({ ...prev, [courseId]: data || [] }));
    } catch (error) {
      console.error('Error loading lessons:', error);
    }
  }

  function handleCourseClick(courseId: string) {
    if (expandedCourse === courseId) {
      setExpandedCourse(null);
    } else {
      setExpandedCourse(courseId);
      loadLessons(courseId);
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 flex items-center justify-center">
        <div className="text-xl text-slate-600">Loading courses...</div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
      <div className="max-w-5xl mx-auto px-4 py-8">
        <button
          onClick={onNavigateHome}
          className="flex items-center text-slate-600 hover:text-slate-900 mb-8 transition-colors"
        >
          <ArrowLeft className="w-5 h-5 mr-2" />
          Back to Home
        </button>

        <header className="mb-12">
          <h1 className="text-5xl font-bold text-slate-900 mb-4">Choose Your Path</h1>
          <p className="text-lg text-slate-600">
            Select a language and explore courses tailored to your learning goals
          </p>
        </header>

        <section className="bg-white rounded-xl shadow-lg p-8 mb-8">
          <div className="flex items-center mb-6">
            <Languages className="w-6 h-6 text-blue-600 mr-3" />
            <h2 className="text-2xl font-bold text-slate-900">Select Language</h2>
          </div>

          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            {languages.map((lang) => (
              <button
                key={lang.id}
                onClick={() => setSelectedLanguage(lang)}
                className={`p-4 rounded-lg border-2 transition-all ${
                  selectedLanguage?.id === lang.id
                    ? 'border-blue-600 bg-blue-50 text-blue-700 shadow-md'
                    : 'border-slate-200 bg-white text-slate-700 hover:border-blue-300 hover:bg-slate-50'
                }`}
              >
                <div className="font-semibold text-lg">{lang.name}</div>
              </button>
            ))}
          </div>
        </section>

        {selectedLanguage && courses.length > 0 && (
          <section className="bg-white rounded-xl shadow-lg p-8">
            <h2 className="text-2xl font-bold text-slate-900 mb-6">
              Available Courses
            </h2>

            <div className="space-y-4">
              {courses.map((course) => (
                <div key={course.id} className="border border-slate-200 rounded-lg overflow-hidden">
                  <button
                    onClick={() => handleCourseClick(course.id)}
                    className="w-full px-6 py-4 flex items-center justify-between bg-slate-50 hover:bg-slate-100 transition-colors"
                  >
                    <div className="text-left">
                      <h3 className="text-xl font-bold text-slate-900">{course.title}</h3>
                      <p className="text-slate-600 mt-1">{course.description}</p>
                    </div>
                    {expandedCourse === course.id ? (
                      <ChevronDown className="w-6 h-6 text-slate-600 flex-shrink-0 ml-4" />
                    ) : (
                      <ChevronRight className="w-6 h-6 text-slate-600 flex-shrink-0 ml-4" />
                    )}
                  </button>

                  {expandedCourse === course.id && lessons[course.id] && (
                    <div className="bg-white px-6 py-4">
                      <div className="space-y-2">
                        {lessons[course.id].map((lesson) => (
                          <button
                            key={lesson.id}
                            onClick={() => onSelectLesson(lesson)}
                            className="w-full px-4 py-3 flex items-center justify-between bg-white border border-slate-200 rounded-lg hover:bg-blue-50 hover:border-blue-300 transition-all group"
                          >
                            <div className="text-left">
                              <div className="font-semibold text-slate-900 group-hover:text-blue-700">
                                {lesson.title}
                              </div>
                              <div className="text-sm text-slate-500">
                                Phoneme: {lesson.phoneme}
                              </div>
                            </div>
                            <ChevronRight className="w-5 h-5 text-slate-400 group-hover:text-blue-600" />
                          </button>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
              ))}
            </div>
          </section>
        )}
      </div>
    </div>
  );
}
