import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export type Language = {
  id: string;
  name: string;
  code: string;
  is_active: boolean;
  created_at: string;
};

export type Course = {
  id: string;
  language_id: string;
  title: string;
  description: string;
  order_index: number;
  created_at: string;
};

export type Lesson = {
  id: string;
  course_id: string;
  title: string;
  phoneme: string;
  animation_url: string;
  vibration_pattern: {
    motors: Array<{
      M1: number;
      M2: number;
      M3: number;
      M4: number;
      duration: number;
    }>;
    notes?: string;
    pause?: number;
    repeat?: number;
  };
  order_index: number;
  created_at: string;
};

export type UserProgress = {
  id: string;
  user_id: string;
  lesson_id: string;
  completed: boolean;
  accuracy_score: number;
  attempts: number;
  last_practiced: string;
  created_at: string;
};
