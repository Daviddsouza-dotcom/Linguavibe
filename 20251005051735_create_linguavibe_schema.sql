/*
  # LinguaVibe Database Schema

  1. New Tables
    - `languages`
      - `id` (uuid, primary key) - Unique identifier for each language
      - `name` (text) - Language name (e.g., "English")
      - `code` (text) - Language code (e.g., "en")
      - `is_active` (boolean) - Whether the language is currently available
      - `created_at` (timestamptz) - Timestamp when language was added
    
    - `courses`
      - `id` (uuid, primary key) - Unique identifier for each course
      - `language_id` (uuid, foreign key) - Reference to languages table
      - `title` (text) - Course title (e.g., "Learn Phonemes")
      - `description` (text) - Course description
      - `order_index` (integer) - Display order
      - `created_at` (timestamptz) - Timestamp when course was created
    
    - `lessons`
      - `id` (uuid, primary key) - Unique identifier for each lesson
      - `course_id` (uuid, foreign key) - Reference to courses table
      - `title` (text) - Lesson title (e.g., "Phoneme /æ/")
      - `phoneme` (text) - The phoneme being taught
      - `animation_url` (text) - URL or path to animation
      - `vibration_pattern` (jsonb) - Array of vibration sequences for ESP32
      - `order_index` (integer) - Display order within course
      - `created_at` (timestamptz) - Timestamp when lesson was created
    
    - `user_progress`
      - `id` (uuid, primary key) - Unique identifier for progress record
      - `user_id` (uuid) - User identifier (for future auth integration)
      - `lesson_id` (uuid, foreign key) - Reference to lessons table
      - `completed` (boolean) - Whether lesson is completed
      - `accuracy_score` (integer) - Pronunciation accuracy (0-100)
      - `attempts` (integer) - Number of practice attempts
      - `last_practiced` (timestamptz) - Last practice timestamp
      - `created_at` (timestamptz) - First attempt timestamp

  2. Security
    - Enable RLS on all tables
    - Add policies for public read access (since auth is not implemented yet)
    - User progress will be restricted once auth is added

  3. Indexes
    - Add indexes on foreign keys for better query performance
    - Add index on language code for quick lookups
*/

-- Create languages table
CREATE TABLE IF NOT EXISTS languages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  code text UNIQUE NOT NULL,
  is_active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

-- Create courses table
CREATE TABLE IF NOT EXISTS courses (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  language_id uuid REFERENCES languages(id) ON DELETE CASCADE,
  title text NOT NULL,
  description text DEFAULT '',
  order_index integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create lessons table
CREATE TABLE IF NOT EXISTS lessons (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  course_id uuid REFERENCES courses(id) ON DELETE CASCADE,
  title text NOT NULL,
  phoneme text NOT NULL,
  animation_url text DEFAULT '',
  vibration_pattern jsonb DEFAULT '[]'::jsonb,
  order_index integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create user_progress table
CREATE TABLE IF NOT EXISTS user_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  lesson_id uuid REFERENCES lessons(id) ON DELETE CASCADE,
  completed boolean DEFAULT false,
  accuracy_score integer DEFAULT 0,
  attempts integer DEFAULT 0,
  last_practiced timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_courses_language_id ON courses(language_id);
CREATE INDEX IF NOT EXISTS idx_lessons_course_id ON lessons(course_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_lesson_id ON user_progress(lesson_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_user_id ON user_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_languages_code ON languages(code);

-- Enable RLS
ALTER TABLE languages ENABLE ROW LEVEL SECURITY;
ALTER TABLE courses ENABLE ROW LEVEL SECURITY;
ALTER TABLE lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;

-- RLS Policies for public read access (temporary until auth is implemented)
CREATE POLICY "Public can view active languages"
  ON languages FOR SELECT
  USING (is_active = true);

CREATE POLICY "Public can view courses"
  ON courses FOR SELECT
  USING (true);

CREATE POLICY "Public can view lessons"
  ON lessons FOR SELECT
  USING (true);

CREATE POLICY "Users can view own progress"
  ON user_progress FOR SELECT
  USING (true);

CREATE POLICY "Users can insert own progress"
  ON user_progress FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Users can update own progress"
  ON user_progress FOR UPDATE
  USING (true)
  WITH CHECK (true);

-- Insert initial data
INSERT INTO languages (name, code, is_active) 
VALUES ('English', 'en', true)
ON CONFLICT (code) DO NOTHING;

-- Get the English language ID for course creation
DO $$
DECLARE
  english_id uuid;
  course_id uuid;
BEGIN
  SELECT id INTO english_id FROM languages WHERE code = 'en';
  
  -- Insert Learn Phonemes course
  INSERT INTO courses (language_id, title, description, order_index)
  VALUES (english_id, 'Learn Phonemes', 'Master English phonemes with interactive exercises', 1)
  ON CONFLICT DO NOTHING
  RETURNING id INTO course_id;
  
  -- Insert sample lessons
  IF course_id IS NOT NULL THEN
    INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index)
    VALUES 
      (course_id, 'The /æ/ Sound (cat)', '/æ/', '/animations/phoneme-ae.json', '{"pattern": [200, 100, 200], "intensity": 128}'::jsonb, 1),
      (course_id, 'The /iː/ Sound (see)', '/iː/', '/animations/phoneme-ee.json', '{"pattern": [300, 50, 150], "intensity": 100}'::jsonb, 2),
      (course_id, 'The /ɪ/ Sound (sit)', '/ɪ/', '/animations/phoneme-i.json', '{"pattern": [150, 100, 150], "intensity": 120}'::jsonb, 3),
      (course_id, 'The /ə/ Sound (about)', '/ə/', '/animations/phoneme-schwa.json', '{"pattern": [250, 75, 175], "intensity": 110}'::jsonb, 4),
      (course_id, 'The /ɑː/ Sound (father)', '/ɑː/', '/animations/phoneme-ah.json', '{"pattern": [400, 100, 200], "intensity": 140}'::jsonb, 5)
    ON CONFLICT DO NOTHING;
  END IF;
END $$;