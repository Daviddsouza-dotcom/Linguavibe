/*
  # Complete LinguaVibe Course Structure Update

  1. Schema Changes
    - Update vibration_pattern structure to support 4-motor system (M1, M2, M3, M4)
    - Add example_word field to lessons for better context
    - Add lesson_type field to categorize different lesson types
    
  2. Data Changes
    - Remove old sample lessons
    - Add all 7 courses with complete lesson sets:
      1. Learn Phonemes (44 phonemes: vowels, consonants, diphthongs)
      2. Phoneme Combinations / Syllables (20 lessons: CV, VC, CVC, blends)
      3. Basic Words (20 lessons: 1-syllable, 2-syllable, articulation groups)
      4. Word Stress & Intonation (20 lessons: stress, phrases, emotion)
      5. Phrases & Sentences (20 lessons: simple to complex)
      6. Conversational Practice (20 lessons: greetings to storytelling)
      7. Advanced Pronunciation & Fluency (18 lessons: linking, rhythm, melody)
    
  3. Motor Pattern Structure
    - Each pattern contains M1, M2, M3, M4 values (PWM 0-255)
    - Duration in milliseconds for each motor
    - Sequential patterns for complex sounds
*/

-- First, clear existing lesson data
DELETE FROM user_progress;
DELETE FROM lessons;
DELETE FROM courses;

-- Get English language ID
DO $$
DECLARE
  english_id uuid;
  course1_id uuid;
  course2_id uuid;
  course3_id uuid;
  course4_id uuid;
  course5_id uuid;
  course6_id uuid;
  course7_id uuid;
BEGIN
  SELECT id INTO english_id FROM languages WHERE code = 'en';
  
  -- =====================================================
  -- COURSE 1: Learn Phonemes
  -- =====================================================
  INSERT INTO courses (language_id, title, description, order_index)
  VALUES (english_id, 'Learn Phonemes', 'Master all 44 English phonemes with vibration feedback', 1)
  RETURNING id INTO course1_id;
  
  -- A. VOWELS (12 phonemes)
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course1_id, 'High Front Vowel: see', '/iː/', '/animations/phoneme-ee.json', 
   '{"motors": [{"M1": 50, "M2": 50, "M3": 50, "M4": 50, "duration": 200}], "notes": "High front vowel, short pulse"}'::jsonb, 1),
  
  (course1_id, 'Short Front Vowel: sit', '/ɪ/', '/animations/phoneme-i.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 30, "M4": 30, "duration": 150}], "notes": "Shorter duration"}'::jsonb, 2),
  
  (course1_id, 'Mid Front Vowel: bed', '/e/', '/animations/phoneme-e.json',
   '{"motors": [{"M1": 100, "M2": 100, "M3": 0, "M4": 0, "duration": 180}], "notes": "Mid front vowel"}'::jsonb, 3),
  
  (course1_id, 'Front Open Vowel: cat', '/æ/', '/animations/phoneme-ae.json',
   '{"motors": [{"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 200}], "notes": "Front-open, strong M1"}'::jsonb, 4),
  
  (course1_id, 'Back Vowel: car', '/ɑː/', '/animations/phoneme-ah.json',
   '{"motors": [{"M1": 200, "M2": 0, "M3": 200, "M4": 0, "duration": 250}], "notes": "Back vowel, alternating M1/M3"}'::jsonb, 5),
  
  (course1_id, 'Rounded Back Vowel: hot', '/ɒ/', '/animations/phoneme-o.json',
   '{"motors": [{"M1": 150, "M2": 0, "M3": 100, "M4": 0, "duration": 180}], "notes": "Rounded back vowel"}'::jsonb, 6),
  
  (course1_id, 'Long Back Vowel: saw', '/ɔː/', '/animations/phoneme-aw.json',
   '{"motors": [{"M1": 200, "M2": 0, "M3": 200, "M4": 50, "duration": 250}], "notes": "Long back vowel"}'::jsonb, 7),
  
  (course1_id, 'Short Back Rounded: put', '/ʊ/', '/animations/phoneme-oo.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 100, "M4": 100, "duration": 150}], "notes": "Short back rounded"}'::jsonb, 8),
  
  (course1_id, 'Long Back Rounded: blue', '/uː/', '/animations/phoneme-ue.json',
   '{"motors": [{"M1": 200, "M2": 50, "M3": 200, "M4": 50, "duration": 250}], "notes": "Long back rounded"}'::jsonb, 9),
  
  (course1_id, 'Central Vowel: cup', '/ʌ/', '/animations/phoneme-uh.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 50, "M4": 0, "duration": 180}], "notes": "Central vowel"}'::jsonb, 10),
  
  (course1_id, 'Mid-Central: bird', '/ɜː/', '/animations/phoneme-er.json',
   '{"motors": [{"M1": 100, "M2": 50, "M3": 100, "M4": 50, "duration": 220}], "notes": "Mid-central"}'::jsonb, 11),
  
  (course1_id, 'Schwa: about', '/ə/', '/animations/phoneme-schwa.json',
   '{"motors": [{"M1": 50, "M2": 0, "M3": 50, "M4": 0, "duration": 100}], "notes": "Schwa, short pulse"}'::jsonb, 12);
  
  -- B. CONSONANTS - Plosives (6 phonemes)
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course1_id, 'Unvoiced Bilabial Stop: pat', '/p/', '/animations/phoneme-p.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 80}], "notes": "Front, unvoiced"}'::jsonb, 13),
  
  (course1_id, 'Voiced Bilabial Stop: bat', '/b/', '/animations/phoneme-b.json',
   '{"motors": [{"M1": 100, "M2": 50, "M3": 0, "M4": 0, "duration": 100}], "notes": "Voiced, extra M2"}'::jsonb, 14),
  
  (course1_id, 'Unvoiced Alveolar Stop: top', '/t/', '/animations/phoneme-t.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 0, "M4": 0, "duration": 80}], "notes": "Tip of tongue"}'::jsonb, 15),
  
  (course1_id, 'Voiced Alveolar Stop: dog', '/d/', '/animations/phoneme-d.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 50, "M4": 0, "duration": 100}], "notes": "Voiced, triple pulse"}'::jsonb, 16),
  
  (course1_id, 'Unvoiced Velar Stop: cat', '/k/', '/animations/phoneme-k.json',
   '{"motors": [{"M1": 0, "M2": 0, "M3": 150, "M4": 150, "duration": 100}], "notes": "Back tongue"}'::jsonb, 17),
  
  (course1_id, 'Voiced Velar Stop: go', '/g/', '/animations/phoneme-g.json',
   '{"motors": [{"M1": 0, "M2": 0, "M3": 200, "M4": 200, "duration": 120}], "notes": "Voiced"}'::jsonb, 18);
  
  -- Fricatives (8 phonemes)
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course1_id, 'Unvoiced Labiodental: fun', '/f/', '/animations/phoneme-f.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 50, "duration": 150}], "notes": "Lip friction"}'::jsonb, 19),
  
  (course1_id, 'Voiced Labiodental: van', '/v/', '/animations/phoneme-v.json',
   '{"motors": [{"M1": 100, "M2": 50, "M3": 0, "M4": 50, "duration": 150}], "notes": "Voiced fricative"}'::jsonb, 20),
  
  (course1_id, 'Unvoiced Dental: think', '/θ/', '/animations/phoneme-th.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 50, "M4": 50, "duration": 150}], "notes": "Dental, simultaneous"}'::jsonb, 21),
  
  (course1_id, 'Voiced Dental: this', '/ð/', '/animations/phoneme-dh.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 100, "M4": 50, "duration": 150}], "notes": "Voiced dental"}'::jsonb, 22),
  
  (course1_id, 'Unvoiced Alveolar: sip', '/s/', '/animations/phoneme-s.json',
   '{"motors": [{"M1": 0, "M2": 150, "M3": 150, "M4": 0, "duration": 200}], "notes": "Continuous hiss"}'::jsonb, 23),
  
  (course1_id, 'Voiced Alveolar: zip', '/z/', '/animations/phoneme-z.json',
   '{"motors": [{"M1": 0, "M2": 200, "M3": 200, "M4": 0, "duration": 200}], "notes": "Voiced hiss"}'::jsonb, 24),
  
  (course1_id, 'Unvoiced Postalveolar: ship', '/ʃ/', '/animations/phoneme-sh.json',
   '{"motors": [{"M1": 0, "M2": 100, "M3": 200, "M4": 50, "duration": 200}], "notes": "sh rising pulse"}'::jsonb, 25),
  
  (course1_id, 'Voiced Postalveolar: measure', '/ʒ/', '/animations/phoneme-zh.json',
   '{"motors": [{"M1": 0, "M2": 150, "M3": 200, "M4": 50, "duration": 200}], "notes": "Voiced sh"}'::jsonb, 26);
  
  -- Nasals (3 phonemes)
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course1_id, 'Bilabial Nasal: man', '/m/', '/animations/phoneme-m.json',
   '{"motors": [{"M1": 150, "M2": 0, "M3": 150, "M4": 0, "duration": 200}], "notes": "Bilabial"}'::jsonb, 27),
  
  (course1_id, 'Alveolar Nasal: net', '/n/', '/animations/phoneme-n.json',
   '{"motors": [{"M1": 0, "M2": 150, "M3": 0, "M4": 150, "duration": 200}], "notes": "Alveolar"}'::jsonb, 28),
  
  (course1_id, 'Velar Nasal: sing', '/ŋ/', '/animations/phoneme-ng.json',
   '{"motors": [{"M1": 0, "M2": 0, "M3": 200, "M4": 200, "duration": 200}], "notes": "Velar"}'::jsonb, 29);
  
  -- Approximants (4 phonemes)
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course1_id, 'Lateral Approximant: lip', '/l/', '/animations/phoneme-l.json',
   '{"motors": [{"M1": 50, "M2": 100, "M3": 50, "M4": 0, "duration": 150}], "notes": "Lateral"}'::jsonb, 30),
  
  (course1_id, 'Retroflex Approximant: red', '/r/', '/animations/phoneme-r.json',
   '{"motors": [{"M1": 0, "M2": 100, "M3": 100, "M4": 0, "duration": 150}], "notes": "Retroflex"}'::jsonb, 31),
  
  (course1_id, 'Palatal Approximant: yes', '/j/', '/animations/phoneme-y.json',
   '{"motors": [{"M1": 50, "M2": 0, "M3": 50, "M4": 50, "duration": 120}], "notes": "Palatal glide"}'::jsonb, 32),
  
  (course1_id, 'Labio-velar Approximant: wet', '/w/', '/animations/phoneme-w.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 50, "M4": 50, "duration": 150}], "notes": "Labio-velar glide"}'::jsonb, 33);
  
  -- Affricates (2 phonemes)
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course1_id, 'Unvoiced Affricate: chin', '/tʃ/', '/animations/phoneme-ch.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 100, "M4": 0, "duration": 150}], "notes": "ch stop+fricative"}'::jsonb, 34),
  
  (course1_id, 'Voiced Affricate: jam', '/dʒ/', '/animations/phoneme-j.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 150, "M4": 0, "duration": 150}], "notes": "Voiced ch"}'::jsonb, 35);
  
  -- C. DIPHTHONGS (8 phonemes)
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course1_id, 'Rising Front Diphthong: say', '/eɪ/', '/animations/phoneme-ay.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 100, "M4": 50, "duration": 200}], "notes": "Rising front vowel"}'::jsonb, 36),
  
  (course1_id, 'Low to High Diphthong: my', '/aɪ/', '/animations/phoneme-ai.json',
   '{"motors": [{"M1": 50, "M2": 100, "M3": 50, "M4": 50, "duration": 200}], "notes": "Rising low to high"}'::jsonb, 37),
  
  (course1_id, 'Back to Front Diphthong: boy', '/ɔɪ/', '/animations/phoneme-oi.json',
   '{"motors": [{"M1": 0, "M2": 100, "M3": 150, "M4": 50, "duration": 200}], "notes": "Back to front glide"}'::jsonb, 38),
  
  (course1_id, 'Low to Back Diphthong: now', '/aʊ/', '/animations/phoneme-au.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 150, "M4": 50, "duration": 200}], "notes": "Low to back glide"}'::jsonb, 39),
  
  (course1_id, 'Schwa to Back Diphthong: go', '/əʊ/', '/animations/phoneme-ou.json',
   '{"motors": [{"M1": 50, "M2": 0, "M3": 200, "M4": 50, "duration": 220}], "notes": "Schwa to long back"}'::jsonb, 40),
  
  (course1_id, 'Central to Front: here', '/ɪə/', '/animations/phoneme-ia.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 50, "M4": 100, "duration": 200}], "notes": "Central to front"}'::jsonb, 41),
  
  (course1_id, 'Mid to Central: care', '/eə/', '/animations/phoneme-ea.json',
   '{"motors": [{"M1": 100, "M2": 50, "M3": 50, "M4": 100, "duration": 200}], "notes": "Mid to central"}'::jsonb, 42),
  
  (course1_id, 'Rounded to Central: pure', '/ʊə/', '/animations/phoneme-ua.json',
   '{"motors": [{"M1": 50, "M2": 0, "M3": 150, "M4": 100, "duration": 200}], "notes": "Rounded to central"}'::jsonb, 43);

  -- =====================================================
  -- COURSE 2: Phoneme Combinations / Syllables
  -- =====================================================
  INSERT INTO courses (language_id, title, description, order_index)
  VALUES (english_id, 'Phoneme Combinations / Syllables', 'Learn to blend phonemes into syllables with rhythm and flow', 2)
  RETURNING id INTO course2_id;
  
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course2_id, 'Plosive + Vowel (pa, ba, ta)', 'CV', '/animations/cv-plosive.json',
   '{"motors": [{"M1": 100, "M2": 50, "M3": 0, "M4": 0, "duration": 80}, {"M1": 200, "M2": 0, "M3": 0, "M4": 0, "duration": 200}], "notes": "Sharp pulse then sustained"}'::jsonb, 1),
  
  (course2_id, 'Nasal + Vowel (ma, na)', 'CV', '/animations/cv-nasal.json',
   '{"motors": [{"M1": 150, "M2": 0, "M3": 150, "M4": 0, "duration": 100}, {"M1": 200, "M2": 50, "M3": 0, "M4": 0, "duration": 200}], "notes": "Soft hum to vowel"}'::jsonb, 2),
  
  (course2_id, 'Fricative + Vowel (fa, sa)', 'CV', '/animations/cv-fricative.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 200}, {"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 200}], "notes": "Continuous merge"}'::jsonb, 3),
  
  (course2_id, 'Approximant + Vowel (la, wa)', 'CV', '/animations/cv-approximant.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 50, "M4": 50, "duration": 150}, {"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 200}], "notes": "Smooth glide"}'::jsonb, 4),
  
  (course2_id, 'Vowel + Plosive (ap, at)', 'VC', '/animations/vc-plosive.json',
   '{"motors": [{"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 200}, {"M1": 50, "M2": 50, "M3": 0, "M4": 0, "duration": 80}], "notes": "Long to short burst"}'::jsonb, 5),
  
  (course2_id, 'Long Vowel + Consonant (aim, eel)', 'VC', '/animations/vc-long.json',
   '{"motors": [{"M1": 200, "M2": 100, "M3": 0, "M4": 0, "duration": 250}, {"M1": 80, "M2": 80, "M3": 0, "M4": 0, "duration": 100}], "notes": "Extended vowel"}'::jsonb, 6),
  
  (course2_id, 'Vowel + Fricative (as, of)', 'VC', '/animations/vc-fricative.json',
   '{"motors": [{"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 200}, {"M2": 100, "M3": 100, "M1": 0, "M4": 0, "duration": 150}], "notes": "Fading end"}'::jsonb, 7),
  
  (course2_id, 'Vowel + Nasal (am, in)', 'VC', '/animations/vc-nasal.json',
   '{"motors": [{"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 200}, {"M1": 100, "M2": 0, "M3": 100, "M4": 0, "duration": 150}], "notes": "Soft hum end"}'::jsonb, 8),
  
  (course2_id, 'Front CVC (pat, bat)', 'CVC', '/animations/cvc-front.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 80}, {"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 150}, {"M1": 50, "M2": 50, "M3": 0, "M4": 0, "duration": 80}], "notes": "Front-mid-front"}'::jsonb, 9),
  
  (course2_id, 'Back CVC (cat, dog)', 'CVC', '/animations/cvc-back.json',
   '{"motors": [{"M3": 150, "M4": 150, "M1": 0, "M2": 0, "duration": 100}, {"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 150}, {"M3": 150, "M4": 150, "M1": 0, "M2": 0, "duration": 100}], "notes": "Back-front-back"}'::jsonb, 10),
  
  (course2_id, 'Mixed CVC (man, sun)', 'CVC', '/animations/cvc-mixed.json',
   '{"motors": [{"M1": 150, "M3": 150, "M2": 0, "M4": 0, "duration": 100}, {"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 150}, {"M2": 150, "M4": 150, "M1": 0, "M3": 0, "duration": 100}], "notes": "Varied articulation"}'::jsonb, 11),
  
  (course2_id, 'Long Vowel CVC (seed, moon)', 'CVC', '/animations/cvc-long.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 0, "M4": 0, "duration": 80}, {"M1": 200, "M2": 200, "M3": 200, "M4": 200, "duration": 250}, {"M3": 100, "M4": 0, "M1": 0, "M2": 0, "duration": 100}], "notes": "Prolonged center"}'::jsonb, 12),
  
  (course2_id, 'Initial Blends (bl, pl, tr)', 'CCV', '/animations/blend-initial.json',
   '{"motors": [{"M1": 50, "M2": 0, "M3": 0, "M4": 0, "duration": 60}, {"M2": 50, "M1": 0, "M3": 0, "M4": 0, "duration": 60}, {"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 200}], "notes": "Two consonants then vowel"}'::jsonb, 13),
  
  (course2_id, 'Final Blends (milk, hand)', 'CVCC', '/animations/blend-final.json',
   '{"motors": [{"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 200}, {"M2": 100, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M1": 80, "M3": 80, "M2": 0, "M4": 0, "duration": 80}], "notes": "Rapid dual end"}'::jsonb, 14),
  
  (course2_id, 'Nasal Blends (sn, sm)', 'Blend', '/animations/blend-nasal.json',
   '{"motors": [{"M2": 100, "M1": 0, "M3": 0, "M4": 0, "duration": 120}, {"M1": 100, "M3": 100, "M2": 0, "M4": 0, "duration": 150}], "notes": "Nasal overlay"}'::jsonb, 15),
  
  (course2_id, 'Syllable Flow (bat to baton)', 'Multi', '/animations/syllable-flow.json',
   '{"motors": [{"M1": 100, "M2": 50, "M3": 0, "M4": 0, "duration": 80}, {"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 150}, {"M1": 50, "M2": 50, "M3": 0, "M4": 0, "duration": 80}], "notes": "Smooth transition"}'::jsonb, 16),
  
  (course2_id, 'Minimal Pair: pa vs ba', 'Pair', '/animations/pair-pb.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 80}, {"M1": 100, "M2": 50, "M3": 0, "M4": 0, "duration": 100}], "notes": "Voice distinction"}'::jsonb, 17),
  
  (course2_id, 'Minimal Pair: sa vs sha', 'Pair', '/animations/pair-ssha.json',
   '{"motors": [{"M2": 150, "M3": 150, "M1": 0, "M4": 0, "duration": 200}, {"M2": 100, "M3": 200, "M4": 50, "M1": 0, "duration": 200}], "notes": "Place distinction"}'::jsonb, 18),
  
  (course2_id, 'Rhythm Practice (papa, mama)', 'Rhythm', '/animations/rhythm-pattern.json',
   '{"motors": [{"M1": 200, "M2": 100, "M3": 0, "M4": 0, "duration": 150}, {"M1": 120, "M2": 60, "M3": 0, "M4": 0, "duration": 100}, {"M1": 200, "M2": 100, "M3": 0, "M4": 0, "duration": 150}, {"M1": 120, "M2": 60, "M3": 0, "M4": 0, "duration": 100}], "notes": "Stress rhythm"}'::jsonb, 19),
  
  (course2_id, 'Multi-syllable (banana)', 'Rhythm', '/animations/multisyllable.json',
   '{"motors": [{"M1": 120, "M2": 60, "M3": 0, "M4": 0, "duration": 100}, {"M1": 200, "M2": 100, "M3": 0, "M4": 0, "duration": 150}, {"M1": 120, "M2": 60, "M3": 0, "M4": 0, "duration": 100}], "notes": "Varied intensity"}'::jsonb, 20);

  -- =====================================================
  -- COURSE 3: Basic Words
  -- =====================================================
  INSERT INTO courses (language_id, title, description, order_index)
  VALUES (english_id, 'Basic Words', 'Build vocabulary with simple 1 and 2 syllable words', 3)
  RETURNING id INTO course3_id;
  
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course3_id, 'cat', 'CVC Word', '/animations/word-cat.json',
   '{"motors": [{"M3": 150, "M4": 150, "M1": 0, "M2": 0, "duration": 100}, {"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 150}, {"M1": 50, "M2": 50, "M3": 0, "M4": 0, "duration": 80}], "notes": "Back-front-front"}'::jsonb, 1),
  
  (course3_id, 'dog', 'CVC Word', '/animations/word-dog.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 50, "M4": 0, "duration": 100}, {"M1": 150, "M3": 100, "M2": 0, "M4": 0, "duration": 150}, {"M3": 200, "M4": 200, "M1": 0, "M2": 0, "duration": 120}], "notes": "Mid-front-back"}'::jsonb, 2),
  
  (course3_id, 'sun', 'CVC Word', '/animations/word-sun.json',
   '{"motors": [{"M2": 150, "M1": 0, "M3": 0, "M4": 0, "duration": 150}, {"M1": 100, "M3": 50, "M2": 0, "M4": 0, "duration": 180}, {"M1": 100, "M3": 100, "M2": 0, "M4": 0, "duration": 150}], "notes": "Fricative-central-nasal"}'::jsonb, 3),
  
  (course3_id, 'map', 'CVC Word', '/animations/word-map.json',
   '{"motors": [{"M1": 150, "M3": 150, "M2": 0, "M4": 0, "duration": 150}, {"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 150}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 80}], "notes": "Nasal-vowel-plosive"}'::jsonb, 4),
  
  (course3_id, 'fish', 'CVC Word', '/animations/word-fish.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 150}, {"M1": 50, "M2": 50, "M3": 0, "M4": 0, "duration": 150}, {"M2": 100, "M3": 100, "M4": 100, "M1": 0, "duration": 180}], "notes": "Fricative-vowel-sh"}'::jsonb, 5),
  
  (course3_id, 'cup', 'CVC Word', '/animations/word-cup.json',
   '{"motors": [{"M3": 150, "M4": 150, "M1": 0, "M2": 0, "duration": 100}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 180}, {"M1": 80, "M2": 0, "M3": 0, "M4": 0, "duration": 80}], "notes": "Back-center-front"}'::jsonb, 6),
  
  (course3_id, 'bed', 'CVC Word', '/animations/word-bed.json',
   '{"motors": [{"M1": 100, "M2": 50, "M3": 0, "M4": 0, "duration": 100}, {"M1": 100, "M2": 100, "M3": 0, "M4": 0, "duration": 180}, {"M1": 80, "M2": 80, "M3": 0, "M4": 0, "duration": 100}], "notes": "Front voiced"}'::jsonb, 7),
  
  (course3_id, 'book', 'CVC Word', '/animations/word-book.json',
   '{"motors": [{"M1": 100, "M2": 50, "M3": 0, "M4": 0, "duration": 100}, {"M1": 200, "M2": 50, "M3": 200, "M4": 50, "duration": 200}, {"M3": 150, "M4": 150, "M1": 0, "M2": 0, "duration": 100}], "notes": "Back transition"}'::jsonb, 8),
  
  (course3_id, 'baby', '2-Syllable', '/animations/word-baby.json',
   '{"motors": [{"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 150}, {"M1": 100, "M2": 100, "M3": 0, "M4": 0, "duration": 120}], "notes": "Light second syllable"}'::jsonb, 9),
  
  (course3_id, 'water', '2-Syllable', '/animations/word-water.json',
   '{"motors": [{"M1": 100, "M2": 100, "M3": 100, "M4": 100, "duration": 200}, {"M1": 50, "M2": 50, "M3": 50, "M4": 0, "duration": 100}], "notes": "Stress first"}'::jsonb, 10),
  
  (course3_id, 'happy', '2-Syllable', '/animations/word-happy.json',
   '{"motors": [{"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 150}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "notes": "Strong-weak"}'::jsonb, 11),
  
  (course3_id, 'table', '2-Syllable', '/animations/word-table.json',
   '{"motors": [{"M1": 50, "M2": 50, "M3": 0, "M4": 0, "duration": 80}, {"M1": 100, "M2": 50, "M3": 50, "M4": 0, "duration": 150}], "notes": "Transition pattern"}'::jsonb, 12),
  
  (course3_id, 'coffee', '2-Syllable', '/animations/word-coffee.json',
   '{"motors": [{"M3": 150, "M4": 100, "M1": 0, "M2": 0, "duration": 150}, {"M1": 100, "M2": 50, "M3": 0, "M4": 0, "duration": 200}], "notes": "Smooth transition"}'::jsonb, 13),
  
  (course3_id, 'pet (front articulation)', 'Front', '/animations/word-pet.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 80}, {"M1": 100, "M2": 100, "M3": 0, "M4": 0, "duration": 180}, {"M1": 50, "M2": 50, "M3": 0, "M4": 0, "duration": 80}], "notes": "Front focus"}'::jsonb, 14),
  
  (course3_id, 'lip (front articulation)', 'Front', '/animations/word-lip.json',
   '{"motors": [{"M1": 50, "M2": 100, "M3": 50, "M4": 0, "duration": 150}, {"M1": 50, "M2": 50, "M3": 0, "M4": 0, "duration": 150}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 80}], "notes": "Lateral to front"}'::jsonb, 15),
  
  (course3_id, 'run (mid articulation)', 'Mid', '/animations/word-run.json',
   '{"motors": [{"M2": 100, "M3": 100, "M1": 0, "M4": 0, "duration": 150}, {"M1": 100, "M3": 50, "M2": 0, "M4": 0, "duration": 180}, {"M1": 100, "M3": 100, "M2": 0, "M4": 0, "duration": 150}], "notes": "Central control"}'::jsonb, 16),
  
  (course3_id, 'go (back articulation)', 'Back', '/animations/word-go.json',
   '{"motors": [{"M3": 200, "M4": 200, "M1": 0, "M2": 0, "duration": 120}, {"M1": 50, "M2": 0, "M3": 200, "M4": 50, "duration": 220}], "notes": "Deep back"}'::jsonb, 17),
  
  (course3_id, 'king (back articulation)', 'Back', '/animations/word-king.json',
   '{"motors": [{"M3": 150, "M4": 150, "M1": 0, "M2": 0, "duration": 100}, {"M1": 50, "M2": 50, "M3": 50, "M4": 50, "duration": 200}, {"M3": 200, "M4": 200, "M1": 0, "M2": 0, "duration": 200}], "notes": "Nasal fade"}'::jsonb, 18),
  
  (course3_id, 'milk (mixed)', 'Mixed', '/animations/word-milk.json',
   '{"motors": [{"M1": 150, "M3": 150, "M2": 0, "M4": 0, "duration": 150}, {"M1": 50, "M2": 50, "M3": 50, "M4": 50, "duration": 200}, {"M1": 50, "M2": 100, "M3": 50, "M4": 0, "duration": 150}, {"M3": 150, "M4": 150, "M1": 0, "M2": 0, "duration": 100}], "notes": "Sequential transition"}'::jsonb, 19),
  
  (course3_id, 'sand (mixed)', 'Mixed', '/animations/word-sand.json',
   '{"motors": [{"M2": 150, "M1": 0, "M3": 0, "M4": 0, "duration": 150}, {"M1": 150, "M2": 50, "M3": 0, "M4": 0, "duration": 150}, {"M1": 100, "M3": 100, "M2": 0, "M4": 0, "duration": 150}, {"M1": 50, "M2": 50, "M3": 50, "M4": 0, "duration": 100}], "notes": "Full mapping"}'::jsonb, 20);

  -- Continue in next part due to size...
  
END $$;