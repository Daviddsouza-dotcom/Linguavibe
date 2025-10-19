/*
  # Add Remaining Courses (4-7)

  1. Course 4: Word Stress & Intonation
  2. Course 5: Phrases & Sentences
  3. Course 6: Conversational Practice
  4. Course 7: Advanced Pronunciation & Fluency
*/

DO $$
DECLARE
  english_id uuid;
  course4_id uuid;
  course5_id uuid;
  course6_id uuid;
  course7_id uuid;
BEGIN
  SELECT id INTO english_id FROM languages WHERE code = 'en';
  
  -- =====================================================
  -- COURSE 4: Word Stress & Intonation
  -- =====================================================
  INSERT INTO courses (language_id, title, description, order_index)
  VALUES (english_id, 'Word Stress & Intonation', 'Feel the rhythm and melody of English speech', 4)
  RETURNING id INTO course4_id;
  
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course4_id, 'First Syllable Stress: TAble', 'Stress', '/animations/stress-first.json',
   '{"motors": [{"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 200}, {"M1": 120, "M2": 120, "M3": 0, "M4": 0, "duration": 100}], "notes": "Strong start, soft end"}'::jsonb, 1),
  
  (course4_id, 'Second Syllable Stress: giTAR', 'Stress', '/animations/stress-second.json',
   '{"motors": [{"M3": 120, "M4": 120, "M1": 0, "M2": 0, "duration": 100}, {"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 200}], "notes": "Weak to strong"}'::jsonb, 2),
  
  (course4_id, 'Second Syllable Stress: aBOUT', 'Stress', '/animations/stress-about.json',
   '{"motors": [{"M1": 80, "M2": 80, "M3": 0, "M4": 0, "duration": 80}, {"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 200}], "notes": "Rising emphasis"}'::jsonb, 3),
  
  (course4_id, 'First Syllable Stress: COMfort', 'Stress', '/animations/stress-comfort.json',
   '{"motors": [{"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 200}, {"M1": 80, "M2": 80, "M3": 0, "M4": 0, "duration": 100}], "notes": "Drop at end"}'::jsonb, 4),
  
  (course4_id, 'Phrase Stress: I WANT a cat', 'Phrase', '/animations/phrase-want.json',
   '{"motors": [{"M1": 150, "M2": 150, "M3": 0, "M4": 0, "duration": 100}, {"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 250}, {"M1": 120, "M2": 120, "M3": 0, "M4": 0, "duration": 80}, {"M1": 180, "M2": 180, "M3": 0, "M4": 0, "duration": 150}], "notes": "Mid emphasis"}'::jsonb, 5),
  
  (course4_id, 'Phrase Stress: HE likes apples', 'Phrase', '/animations/phrase-he.json',
   '{"motors": [{"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 250}, {"M1": 150, "M2": 150, "M3": 0, "M4": 0, "duration": 120}, {"M1": 180, "M2": 180, "M3": 0, "M4": 0, "duration": 150}], "notes": "Early stress"}'::jsonb, 6),
  
  (course4_id, 'Phrase Stress: ICE cream', 'Phrase', '/animations/phrase-ice.json',
   '{"motors": [{"M1": 200, "M2": 200, "M3": 200, "M4": 0, "duration": 200}, {"M1": 180, "M2": 180, "M3": 0, "M4": 0, "duration": 150}], "notes": "Adjective focus"}'::jsonb, 7),
  
  (course4_id, 'Phrase Stress: VERY happy', 'Phrase', '/animations/phrase-very.json',
   '{"motors": [{"M1": 255, "M2": 255, "M3": 0, "M4": 0, "duration": 200}, {"M1": 150, "M2": 150, "M3": 0, "M4": 0, "duration": 150}], "notes": "Emotional emphasis"}'::jsonb, 8),
  
  (course4_id, 'Falling Tone: This is my bag.', 'Statement', '/animations/tone-falling.json',
   '{"motors": [{"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 180, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 180, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 100}], "notes": "Natural fall"}'::jsonb, 9),
  
  (course4_id, 'Rising Tone: Is this your bag?', 'Question', '/animations/tone-rising.json',
   '{"motors": [{"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M3": 180, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M2": 180, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "notes": "Rising end"}'::jsonb, 10),
  
  (course4_id, 'Flat Tone: He is reading.', 'Neutral', '/animations/tone-flat.json',
   '{"motors": [{"M1": 180, "M2": 180, "M3": 180, "M4": 180, "duration": 150}], "notes": "Constant tone"}'::jsonb, 11),
  
  (course4_id, 'Rise-Fall: Really?', 'Surprise', '/animations/tone-risefall.json',
   '{"motors": [{"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 80}, {"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 80}, {"M3": 180, "M1": 0, "M2": 0, "M4": 0, "duration": 80}, {"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 80}], "notes": "Pitch swing"}'::jsonb, 12),
  
  (course4_id, 'Happy Emotion: That''s great!', 'Happy', '/animations/emotion-happy.json',
   '{"motors": [{"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 80}, {"M2": 180, "M1": 0, "M3": 0, "M4": 0, "duration": 80}, {"M3": 180, "M1": 0, "M2": 0, "M4": 0, "duration": 80}], "notes": "Quick light pulses"}'::jsonb, 13),
  
  (course4_id, 'Sad Emotion: I''m sorry...', 'Sad', '/animations/emotion-sad.json',
   '{"motors": [{"M4": 150, "M1": 0, "M2": 0, "M3": 0, "duration": 250}, {"M3": 150, "M1": 0, "M2": 0, "M4": 0, "duration": 250}], "notes": "Slow descending"}'::jsonb, 14),
  
  (course4_id, 'Angry Emotion: Stop that!', 'Angry', '/animations/emotion-angry.json',
   '{"motors": [{"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 100}, {"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 100}, {"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 100}], "notes": "Sharp intense"}'::jsonb, 15),
  
  (course4_id, 'Surprised Emotion: What!?', 'Surprised', '/animations/emotion-surprised.json',
   '{"motors": [{"M1": 255, "M4": 0, "M2": 0, "M3": 0, "duration": 70}, {"M4": 255, "M1": 0, "M2": 0, "M3": 0, "duration": 70}, {"M1": 255, "M4": 0, "M2": 0, "M3": 0, "duration": 70}, {"M4": 255, "M1": 0, "M2": 0, "M3": 0, "duration": 70}], "notes": "Rapid alternation"}'::jsonb, 16),
  
  (course4_id, 'Curious Emotion: Really?', 'Curious', '/animations/emotion-curious.json',
   '{"motors": [{"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M2": 180, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "notes": "Soft rising hold"}'::jsonb, 17),
  
  (course4_id, 'Rhythm Training: HAppy-WAt-er', 'Rhythm', '/animations/rhythm-practice.json',
   '{"motors": [{"M1": 255, "M2": 255, "M3": 0, "M4": 0, "duration": 200}, {"M1": 120, "M2": 120, "M3": 0, "M4": 0, "duration": 100}, {"M1": 200, "M2": 200, "M3": 0, "M4": 0, "duration": 180}, {"M1": 100, "M2": 100, "M3": 0, "M4": 0, "duration": 100}], "notes": "Variable intensity"}'::jsonb, 18),
  
  (course4_id, 'Sentence Melody Flow', 'Melody', '/animations/melody-flow.json',
   '{"motors": [{"M1": 200, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 180, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 160, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M4": 150, "M1": 0, "M2": 0, "M3": 0, "duration": 120}], "notes": "Natural melody"}'::jsonb, 19),
  
  (course4_id, 'Story Rhythm Practice', 'Story', '/animations/story-rhythm.json',
   '{"motors": [{"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 180, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 180, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 100}], "notes": "Sentence flow"}'::jsonb, 20);

  -- =====================================================
  -- COURSE 5: Phrases & Sentences
  -- =====================================================
  INSERT INTO courses (language_id, title, description, order_index)
  VALUES (english_id, 'Phrases & Sentences', 'Practice natural speech patterns and sentence rhythm', 5)
  RETURNING id INTO course5_id;
  
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course5_id, 'Good morning', 'Phrase', '/animations/phrase-goodmorning.json',
   '{"motors": [{"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 200}, {"M1": 180, "M2": 180, "M3": 0, "M4": 0, "duration": 150}], "pause": 80, "notes": "Stress first word"}'::jsonb, 1),
  
  (course5_id, 'Thank you', 'Phrase', '/animations/phrase-thankyou.json',
   '{"motors": [{"M1": 255, "M2": 255, "M3": 0, "M4": 0, "duration": 200}, {"M1": 200, "M2": 200, "M3": 200, "M4": 200, "duration": 200}], "pause": 50, "notes": "Equal stress"}'::jsonb, 2),
  
  (course5_id, 'Yes please', 'Phrase', '/animations/phrase-yesplease.json',
   '{"motors": [{"M1": 180, "M3": 0, "M2": 0, "M4": 0, "duration": 80}, {"M3": 180, "M1": 0, "M2": 0, "M4": 0, "duration": 80}, {"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 200}], "notes": "Rising polite"}'::jsonb, 3),
  
  (course5_id, 'No problem', 'Phrase', '/animations/phrase-noproblem.json',
   '{"motors": [{"M1": 220, "M2": 220, "M3": 0, "M4": 0, "duration": 150}, {"M1": 150, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 150, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M4": 150, "M1": 0, "M2": 0, "M3": 0, "duration": 100}], "pause": 100, "notes": "Falling reassurance"}'::jsonb, 4),
  
  (course5_id, 'How are you?', 'Question', '/animations/sentence-howareyou.json',
   '{"motors": [{"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M3": 180, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M2": 180, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "notes": "Rising tone"}'::jsonb, 5),
  
  (course5_id, 'I am fine.', 'Statement', '/animations/sentence-iamfine.json',
   '{"motors": [{"M1": 200, "M2": 0, "M3": 0, "M4": 0, "duration": 120}, {"M2": 200, "M1": 0, "M3": 0, "M4": 0, "duration": 120}, {"M3": 200, "M1": 0, "M2": 0, "M4": 0, "duration": 120}, {"M4": 200, "M1": 0, "M2": 0, "M3": 0, "duration": 120}], "notes": "Falling tone"}'::jsonb, 6),
  
  (course5_id, 'Please sit down.', 'Command', '/animations/sentence-pleasesit.json',
   '{"motors": [{"M1": 255, "M2": 255, "M3": 0, "M4": 0, "duration": 200}, {"M3": 200, "M1": 0, "M2": 0, "M4": 0, "duration": 150}], "notes": "Firm start, soft end"}'::jsonb, 7),
  
  (course5_id, 'Let''s go!', 'Excited', '/animations/sentence-letsgo.json',
   '{"motors": [{"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 100}, {"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 100}, {"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 100}], "notes": "Energetic"}'::jsonb, 8),
  
  (course5_id, 'I like to read books.', 'Complex', '/animations/sentence-ilikebooks.json',
   '{"motors": [{"M1": 150, "M2": 0, "M3": 0, "M4": 0, "duration": 150}, {"M2": 100, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 150, "M1": 0, "M2": 0, "M4": 0, "duration": 150}, {"M1": 200, "M2": 200, "M3": 200, "M4": 200, "duration": 200}], "pause": 80, "notes": "Stress on books"}'::jsonb, 9),
  
  (course5_id, 'She went home, but he stayed.', 'Compound', '/animations/sentence-shewent.json',
   '{"motors": [{"M1": 150, "M2": 150, "M3": 0, "M4": 0, "duration": 150}, {"M3": 200, "M4": 200, "M1": 0, "M2": 0, "duration": 200}, {"M1": 150, "M2": 0, "M3": 0, "M4": 0, "duration": 150}], "pause": 100, "notes": "Mid-sentence pause"}'::jsonb, 10),
  
  (course5_id, 'If you can, please help.', 'Complex', '/animations/sentence-ifyoucan.json',
   '{"motors": [{"M3": 100, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M2": 120, "M1": 0, "M3": 0, "M4": 0, "duration": 120}, {"M1": 200, "M2": 200, "M3": 200, "M4": 200, "duration": 200}, {"M1": 150, "M2": 0, "M3": 0, "M4": 0, "duration": 150}], "pause": 80, "notes": "Stress please and help"}'::jsonb, 11),
  
  (course5_id, 'Because it''s raining, we can''t go.', 'Complex', '/animations/sentence-because.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 100, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 100, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M1": 250, "M2": 250, "M3": 250, "M4": 250, "duration": 250}], "pause": 100, "notes": "Stress on can''t"}'::jsonb, 12),
  
  (course5_id, 'I won the game! (happy)', 'Emotion', '/animations/emotion-iwon.json',
   '{"motors": [{"M4": 80, "M1": 0, "M2": 0, "M3": 0, "duration": 80}, {"M1": 80, "M2": 0, "M3": 0, "M4": 0, "duration": 80}], "repeat": 2, "notes": "Rising bright"}'::jsonb, 13),
  
  (course5_id, 'I lost my friend... (sad)', 'Emotion', '/animations/emotion-ilost.json',
   '{"motors": [{"M1": 200, "M2": 0, "M3": 0, "M4": 0, "duration": 200}, {"M4": 200, "M1": 0, "M2": 0, "M3": 0, "duration": 200}], "notes": "Slow fading"}'::jsonb, 14),
  
  (course5_id, 'Stop doing that! (angry)', 'Emotion', '/animations/emotion-stop.json',
   '{"motors": [{"M1": 250, "M2": 250, "M3": 250, "M4": 250, "duration": 250}], "repeat": 3, "notes": "Strong bursts"}'::jsonb, 15),
  
  (course5_id, 'That''s amazing! (excited)', 'Emotion', '/animations/emotion-amazing.json',
   '{"motors": [{"M1": 150, "M2": 0, "M3": 0, "M4": 0, "duration": 80}, {"M2": 150, "M1": 0, "M3": 0, "M4": 0, "duration": 80}], "repeat": 2, "notes": "Fast high pulses"}'::jsonb, 16),
  
  (course5_id, 'Really? (curious)', 'Emotion', '/animations/emotion-really.json',
   '{"motors": [{"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M2": 100, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "notes": "Gentle rising"}'::jsonb, 17),
  
  (course5_id, 'Greeting dialogue', 'Dialogue', '/animations/dialogue-greeting.json',
   '{"motors": [{"M4": 80, "M1": 0, "M2": 0, "M3": 0, "duration": 80}, {"M1": 80, "M2": 0, "M3": 0, "M4": 0, "duration": 80}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 100, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 100, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}], "notes": "Q rise, A fall"}'::jsonb, 18),
  
  (course5_id, 'Direction question', 'Dialogue', '/animations/dialogue-direction.json',
   '{"motors": [{"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M1": 120, "M2": 0, "M3": 0, "M4": 0, "duration": 120}, {"M4": 120, "M1": 0, "M2": 0, "M3": 0, "duration": 120}], "notes": "Question-answer"}'::jsonb, 19),
  
  (course5_id, 'Story flow practice', 'Story', '/animations/story-flow.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 100, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 100, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M1": 80, "M2": 0, "M3": 0, "M4": 0, "duration": 80}, {"M3": 80, "M1": 0, "M2": 0, "M4": 0, "duration": 80}, {"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "notes": "Multi-sentence rhythm"}'::jsonb, 20);

  -- =====================================================
  -- COURSE 6: Conversational Practice
  -- =====================================================
  INSERT INTO courses (language_id, title, description, order_index)
  VALUES (english_id, 'Conversational Practice', 'Master real-world dialogue and natural conversation flow', 6)
  RETURNING id INTO course6_id;
  
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course6_id, 'Hello! How are you?', 'Greeting', '/animations/conv-hello.json',
   '{"motors": [{"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 200}, {"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "pause": 50, "notes": "Rising question"}'::jsonb, 1),
  
  (course6_id, 'Nice to meet you.', 'Introduction', '/animations/conv-nicetomeet.json',
   '{"motors": [{"M1": 220, "M2": 220, "M3": 0, "M4": 0, "duration": 150}, {"M1": 255, "M2": 255, "M3": 255, "M4": 255, "duration": 200}], "pause": 80, "notes": "Polite stress"}'::jsonb, 2),
  
  (course6_id, 'Same here.', 'Response', '/animations/conv-samehere.json',
   '{"motors": [{"M3": 180, "M4": 180, "M1": 0, "M2": 0, "duration": 150}], "notes": "Soft acknowledgment"}'::jsonb, 3),
  
  (course6_id, 'What''s your name?', 'Question', '/animations/conv-name.json',
   '{"motors": [{"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M3": 100, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M2": 100, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "notes": "Rising question"}'::jsonb, 4),
  
  (course6_id, 'Can you help me?', 'Request', '/animations/conv-help.json',
   '{"motors": [{"M4": 80, "M1": 0, "M2": 0, "M3": 0, "duration": 80}, {"M1": 80, "M2": 0, "M3": 0, "M4": 0, "duration": 80}], "notes": "Polite rise"}'::jsonb, 5),
  
  (course6_id, 'Sure, of course.', 'Response', '/animations/conv-sure.json',
   '{"motors": [{"M1": 200, "M2": 200, "M3": 200, "M4": 200, "duration": 200}, {"M1": 150, "M2": 150, "M3": 0, "M4": 0, "duration": 150}], "pause": 50, "notes": "Positive fall"}'::jsonb, 6),
  
  (course6_id, 'How much is this?', 'Buying', '/animations/conv-howmuch.json',
   '{"motors": [{"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "notes": "Rising price question"}'::jsonb, 7),
  
  (course6_id, 'It''s fifty rupees.', 'Answer', '/animations/conv-fifty.json',
   '{"motors": [{"M1": 120, "M2": 0, "M3": 0, "M4": 0, "duration": 120}, {"M2": 120, "M1": 0, "M3": 0, "M4": 0, "duration": 120}, {"M3": 120, "M1": 0, "M2": 0, "M4": 0, "duration": 120}, {"M4": 120, "M1": 0, "M2": 0, "M3": 0, "duration": 120}], "notes": "Falling answer"}'::jsonb, 8),
  
  (course6_id, 'That''s wonderful! (joy)', 'Emotion', '/animations/conv-wonderful.json',
   '{"motors": [{"M1": 150, "M2": 0, "M3": 0, "M4": 0, "duration": 80}, {"M3": 150, "M1": 0, "M2": 0, "M4": 0, "duration": 80}], "repeat": 2, "notes": "Bright tone"}'::jsonb, 9),
  
  (course6_id, 'I''m feeling down. (sad)', 'Emotion', '/animations/conv-down.json',
   '{"motors": [{"M4": 200, "M1": 0, "M2": 0, "M3": 0, "duration": 200}, {"M3": 200, "M1": 0, "M2": 0, "M4": 0, "duration": 200}], "notes": "Slow falling"}'::jsonb, 10),
  
  (course6_id, 'Leave me alone! (anger)', 'Emotion', '/animations/conv-leave.json',
   '{"motors": [{"M1": 250, "M2": 250, "M3": 250, "M4": 250, "duration": 250}], "repeat": 3, "notes": "Sharp bursts"}'::jsonb, 11),
  
  (course6_id, 'I''m really sorry. (apology)', 'Emotion', '/animations/conv-sorry.json',
   '{"motors": [{"M3": 180, "M1": 0, "M2": 0, "M4": 0, "duration": 150}, {"M4": 150, "M1": 0, "M2": 0, "M3": 0, "duration": 150}], "pause": 100, "notes": "Gentle fade"}'::jsonb, 12),
  
  (course6_id, 'Yesterday I went to the park.', 'Story', '/animations/conv-yesterday.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 100, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 100, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}], "pause": 150, "notes": "Statement fall"}'::jsonb, 13),
  
  (course6_id, 'It was sunny and I met my friend.', 'Story', '/animations/conv-sunny.json',
   '{"motors": [{"M1": 80, "M2": 0, "M3": 0, "M4": 0, "duration": 80}, {"M3": 80, "M1": 0, "M2": 0, "M4": 0, "duration": 80}], "pause": 80, "notes": "Cheerful tone"}'::jsonb, 14),
  
  (course6_id, 'We played games together.', 'Story', '/animations/conv-played.json',
   '{"motors": [{"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "notes": "Rising continuation"}'::jsonb, 15),
  
  (course6_id, 'Small talk: What do you do?', 'SmallTalk', '/animations/conv-whatdoyoudo.json',
   '{"motors": [{"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "notes": "Rising question"}'::jsonb, 16),
  
  (course6_id, 'Small talk reply: I''m a teacher.', 'SmallTalk', '/animations/conv-teacher.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}], "notes": "Falling answer"}'::jsonb, 17),
  
  (course6_id, 'Problem: I can''t find my phone.', 'Problem', '/animations/conv-cantfind.json',
   '{"motors": [{"M1": 200, "M2": 200, "M3": 200, "M4": 200, "duration": 200}, {"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 180}], "pause": 100, "notes": "Stress on can''t"}'::jsonb, 18),
  
  (course6_id, 'Solution: Where did you last see it?', 'Problem', '/animations/conv-wherelast.json',
   '{"motors": [{"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}, {"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}], "notes": "Helpful rising"}'::jsonb, 19),
  
  (course6_id, 'Full conversation practice', 'Dialogue', '/animations/conv-full.json',
   '{"motors": [{"M1": 150, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 150, "M1": 0, "M2": 0, "M4": 0, "duration": 100}], "repeat": 2, "notes": "Multi-turn exchange"}'::jsonb, 20);

  -- =====================================================
  -- COURSE 7: Advanced Pronunciation & Fluency
  -- =====================================================
  INSERT INTO courses (language_id, title, description, order_index)
  VALUES (english_id, 'Advanced Pronunciation & Fluency', 'Perfect your speech with linking, rhythm, and natural flow', 7)
  RETURNING id INTO course7_id;
  
  INSERT INTO lessons (course_id, title, phoneme, animation_url, vibration_pattern, order_index) VALUES
  (course7_id, 'Linking: go on', 'Linking', '/animations/adv-goon.json',
   '{"motors": [{"M1": 200, "M2": 0, "M3": 0, "M4": 0, "duration": 60}, {"M2": 200, "M1": 0, "M3": 0, "M4": 0, "duration": 60}], "notes": "Smooth merge"}'::jsonb, 1),
  
  (course7_id, 'Reduction: want to → wanna', 'Reduction', '/animations/adv-wanna.json',
   '{"motors": [{"M3": 150, "M4": 0, "M1": 0, "M2": 0, "duration": 80}, {"M4": 150, "M1": 0, "M2": 0, "M3": 0, "duration": 80}, {"M1": 220, "M2": 0, "M3": 0, "M4": 0, "duration": 50}], "notes": "Fast reduction"}'::jsonb, 2),
  
  (course7_id, 'Reduction: did you → didja', 'Reduction', '/animations/adv-didja.json',
   '{"motors": [{"M2": 180, "M3": 180, "M1": 0, "M4": 0, "duration": 100}], "notes": "Merge sounds"}'::jsonb, 3),
  
  (course7_id, 'Stress rhythm: TA-ta-TA-ta', 'Rhythm', '/animations/adv-rhythm1.json',
   '{"motors": [{"M1": 220, "M4": 220, "M2": 0, "M3": 0, "duration": 150}, {"M2": 120, "M3": 120, "M1": 0, "M4": 0, "duration": 100}], "repeat": 2, "notes": "Alternating stress"}'::jsonb, 4),
  
  (course7_id, 'Poetry rhythm: 4-beat', 'Rhythm', '/animations/adv-poetry.json',
   '{"motors": [{"M1": 150, "M2": 0, "M3": 0, "M4": 0, "duration": 150}, {"M2": 150, "M1": 0, "M3": 0, "M4": 0, "duration": 150}, {"M3": 150, "M1": 0, "M2": 0, "M4": 0, "duration": 150}, {"M4": 150, "M1": 0, "M2": 0, "M3": 0, "duration": 150}], "notes": "Meter pattern"}'::jsonb, 5),
  
  (course7_id, 'Word rhythm: beautiful day', 'Rhythm', '/animations/adv-beautiful.json',
   '{"motors": [{"M1": 220, "M4": 220, "M2": 0, "M3": 0, "duration": 150}, {"M2": 120, "M3": 120, "M1": 0, "M4": 0, "duration": 100}, {"M1": 220, "M4": 220, "M2": 0, "M3": 0, "duration": 150}], "notes": "Strong-weak-strong"}'::jsonb, 6),
  
  (course7_id, 'Rising pitch: Really?', 'Pitch', '/animations/adv-really.json',
   '{"motors": [{"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 80}, {"M3": 180, "M1": 0, "M2": 0, "M4": 0, "duration": 80}, {"M2": 180, "M1": 0, "M3": 0, "M4": 0, "duration": 80}, {"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 80}], "notes": "Upward contour"}'::jsonb, 7),
  
  (course7_id, 'Falling pitch: Okay.', 'Pitch', '/animations/adv-okay.json',
   '{"motors": [{"M1": 200, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 200, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 200, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M4": 200, "M1": 0, "M2": 0, "M3": 0, "duration": 100}], "notes": "Downward contour"}'::jsonb, 8),
  
  (course7_id, 'Fall-rise: Well...', 'Pitch', '/animations/adv-well.json',
   '{"motors": [{"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 80}, {"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 80}, {"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 80}, {"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 80}], "notes": "Hesitation tone"}'::jsonb, 9),
  
  (course7_id, 'Slow speech: I will wait for you', 'Speed', '/animations/adv-slow.json',
   '{"motors": [{"M1": 150, "M2": 0, "M3": 0, "M4": 0, "duration": 200}, {"M2": 150, "M1": 0, "M3": 0, "M4": 0, "duration": 200}, {"M3": 150, "M1": 0, "M2": 0, "M4": 0, "duration": 200}, {"M4": 150, "M1": 0, "M2": 0, "M3": 0, "duration": 200}], "notes": "Deliberate pace"}'::jsonb, 10),
  
  (course7_id, 'Normal speech: I''ll wait for you', 'Speed', '/animations/adv-normal.json',
   '{"motors": [{"M1": 180, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 180, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 180, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M4": 180, "M1": 0, "M2": 0, "M3": 0, "duration": 100}], "notes": "Natural tempo"}'::jsonb, 11),
  
  (course7_id, 'Fast speech: I''ll wait ya', 'Speed', '/animations/adv-fast.json',
   '{"motors": [{"M1": 220, "M2": 0, "M3": 0, "M4": 0, "duration": 50}, {"M2": 220, "M1": 0, "M3": 0, "M4": 0, "duration": 50}, {"M3": 220, "M1": 0, "M2": 0, "M4": 0, "duration": 50}, {"M4": 220, "M1": 0, "M2": 0, "M3": 0, "duration": 50}], "notes": "Rapid delivery"}'::jsonb, 12),
  
  (course7_id, 'Smooth blending: paragraph flow', 'Blending', '/animations/adv-paragraph.json',
   '{"motors": [{"M1": 100, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 100, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 100, "M1": 0, "M2": 0, "M4": 0, "duration": 100}, {"M4": 100, "M1": 0, "M2": 0, "M3": 0, "duration": 100}], "repeat": 2, "notes": "Continuous wave"}'::jsonb, 13),
  
  (course7_id, 'Long phrase fluency', 'Fluency', '/animations/adv-longphrase.json',
   '{"motors": [{"M1": 230, "M2": 0, "M3": 0, "M4": 0, "duration": 100}, {"M2": 150, "M1": 0, "M3": 0, "M4": 0, "duration": 100}, {"M3": 150, "M1": 0, "M2": 0, "M4": 0, "duration": 100}], "notes": "Stress transition"}'::jsonb, 14),
  
  (course7_id, 'Excited expression: That''s amazing!', 'Expression', '/animations/adv-amazing.json',
   '{"motors": [{"M1": 220, "M2": 0, "M3": 0, "M4": 0, "duration": 70}, {"M3": 220, "M1": 0, "M2": 0, "M4": 0, "duration": 70}], "repeat": 3, "notes": "High energy"}'::jsonb, 15),
  
  (course7_id, 'Sarcastic expression: Oh, great...', 'Expression', '/animations/adv-sarcastic.json',
   '{"motors": [{"M4": 130, "M1": 0, "M2": 0, "M3": 0, "duration": 150}, {"M2": 130, "M1": 0, "M3": 0, "M4": 0, "duration": 150}], "notes": "Flat dismissive"}'::jsonb, 16),
  
  (course7_id, 'Emphasis: I REALLY like it', 'Emphasis', '/animations/adv-really-emphasis.json',
   '{"motors": [{"M1": 230, "M4": 230, "M2": 0, "M3": 0, "duration": 200}, {"M2": 150, "M3": 150, "M1": 0, "M4": 0, "duration": 100}], "notes": "Strong contrast"}'::jsonb, 17),
  
  (course7_id, 'Calm expression: It''s fine.', 'Expression', '/animations/adv-calm.json',
   '{"motors": [{"M2": 150, "M1": 0, "M3": 0, "M4": 0, "duration": 120}, {"M3": 150, "M1": 0, "M2": 0, "M4": 0, "duration": 120}], "notes": "Gentle reassurance"}'::jsonb, 18);

END $$;