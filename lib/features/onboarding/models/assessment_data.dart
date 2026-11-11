// Comprehensive question, ability, and scoring model for the EQi-30 Assessment.
// Built directly from the official EQi 3.0 Psychometric Assessment specification.

class AssessmentQuestion {
  final int id;
  final String text;
  final String competencyKey;
  final String competencyName;
  final String abilityName;
  final bool isReverse;

  const AssessmentQuestion({
    required this.id,
    required this.text,
    required this.competencyKey,
    required this.competencyName,
    required this.abilityName,
    this.isReverse = false,
  });
}

class AbilityInterpretation {
  final String abilityName;
  final String competencyKey;
  final int minScore;
  final int maxScore;
  final String lowCharacteristics;
  final String lowImplications;
  final String mediumCharacteristics;
  final String mediumImplications;
  final String highCharacteristics;
  final String highImplications;

  const AbilityInterpretation({
    required this.abilityName,
    required this.competencyKey,
    this.minScore = 3,
    this.maxScore = 30,
    required this.lowCharacteristics,
    required this.lowImplications,
    required this.mediumCharacteristics,
    required this.mediumImplications,
    required this.highCharacteristics,
    required this.highImplications,
  });

  String getTier(double score) {
    if (score < (maxScore == 40 ? 13 : 10)) {
      return 'Low';
    } else if (score < (maxScore == 40 ? 33 : 25)) {
      return 'Medium';
    } else {
      return 'High';
    }
  }

  String getCharacteristics(double score) {
    final tier = getTier(score);
    if (tier == 'Low') return lowCharacteristics;
    if (tier == 'Medium') return mediumCharacteristics;
    return highCharacteristics;
  }

  String getImplications(double score) {
    final tier = getTier(score);
    if (tier == 'Low') return lowImplications;
    if (tier == 'Medium') return mediumImplications;
    return highImplications;
  }
}

class AssessmentData {
  static const List<Map<String, String>> competencies = [
    {
      'key': 'SELF_MANAGEMENT',
      'name': 'Self-Management',
      'tagline': 'The Operational Engine of your inner life.',
      'icon': '🧠',
    },
    {
      'key': 'INTERPERSONAL_MANAGEMENT',
      'name': 'Interpersonal Management',
      'tagline': 'The bridge you build between yourself and others.',
      'icon': '🤝',
    },
    {
      'key': 'STRESS_MANAGEMENT',
      'name': 'Stress Management',
      'tagline': 'Your Shock Absorbers against adversity.',
      'icon': '🛡️',
    },
    {
      'key': 'SPIRIT_MANAGEMENT',
      'name': 'Spirit Management',
      'tagline': 'Your core values as a Moral Compass.',
      'icon': '⚡',
    },
    {
      'key': 'EXECUTIVE_FUNCTION',
      'name': 'Executive Function',
      'tagline': 'Your ability to plan, prioritize, organize, and follow through.',
      'icon': '📋',
    },
    {
      'key': 'DECISION_MAKING',
      'name': 'Decision Making',
      'tagline': 'How you analyze information and reach sound conclusions.',
      'icon': '⚖️',
    },
  ];

  static const List<AssessmentQuestion> questions = [
    // ----------------------------------------------------
    // COMPETENCY 1: SELF-MANAGEMENT (Questions 1 - 15)
    // ----------------------------------------------------
    // Ability 1: Emotional Awareness
    AssessmentQuestion(
      id: 1,
      text: "I can clearly recognize what I am feeling at the moment.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Emotional Awareness",
    ),
    AssessmentQuestion(
      id: 2,
      text: "I can name my feelings and emotions.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Emotional Awareness",
    ),
    AssessmentQuestion(
      id: 3,
      text: "I am aware of changes in my body as it relates to my feelings.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Emotional Awareness",
    ),
    // Ability 2: Boundary Awareness
    AssessmentQuestion(
      id: 4,
      text: "I don’t ask for what I need if it will make someone else unhappy.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Boundary Awareness",
      isReverse: true,
    ),
    AssessmentQuestion(
      id: 5,
      text: "I can easily separate my own thoughts and opinions from what others think.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Boundary Awareness",
    ),
    AssessmentQuestion(
      id: 6,
      text: "I have difficulty saying no.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Boundary Awareness",
      isReverse: true,
    ),
    // Ability 3: Self-Confidence
    AssessmentQuestion(
      id: 7,
      text: "I accept myself the way I am.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Self-Confidence",
    ),
    AssessmentQuestion(
      id: 8,
      text: "I focus more on my strengths than my weaknesses.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Self-Confidence",
    ),
    AssessmentQuestion(
      id: 9,
      text: "I get defensive when I receive feedback.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Self-Confidence",
      isReverse: true,
    ),
    // Ability 4: Self-Actualization
    AssessmentQuestion(
      id: 10,
      text: "I try to make my life meaningful and work towards clear, specific goals.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Self-Actualization",
    ),
    AssessmentQuestion(
      id: 11,
      text: "I like to keep learning things to add to my personal and professional growth.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Self-Actualization",
    ),
    AssessmentQuestion(
      id: 12,
      text: "In the past few years, I have not accomplished much or grown.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Self-Actualization",
      isReverse: true,
    ),
    // Ability 5: Independence
    AssessmentQuestion(
      id: 13,
      text: "I am influenced by others often.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Independence",
      isReverse: true,
    ),
    AssessmentQuestion(
      id: 14,
      text: "I can direct myself independently at home and at work.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Independence",
    ),
    AssessmentQuestion(
      id: 15,
      text: "I often need reassurance and validation from others.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Independence",
      isReverse: true,
    ),

    // ----------------------------------------------------
    // COMPETENCY 2: INTERPERSONAL MANAGEMENT (Questions 16 - 33)
    // ----------------------------------------------------
    // Ability 6: Empathy
    AssessmentQuestion(
      id: 16,
      text: "My friends confide in me and I understand their feelings.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Empathy",
    ),
    AssessmentQuestion(
      id: 17,
      text: "I am able to express my understanding of someone's feelings and offer support.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Empathy",
    ),
    AssessmentQuestion(
      id: 18,
      text: "At work, I am not focused on other people's feelings.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Empathy",
      isReverse: true,
    ),
    AssessmentQuestion(
      id: 19,
      text: "I am aware of how my emotions impact my relationships with others.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Empathy",
    ),
    // Ability 7: Verbal Expression
    AssessmentQuestion(
      id: 20,
      text: "I calmly, clearly express my thoughts, opinions and emotions in conversations.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Verbal Expression",
    ),
    AssessmentQuestion(
      id: 21,
      text: "I effectively convey complex ideas in simple terms.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Verbal Expression",
    ),
    AssessmentQuestion(
      id: 22,
      text: "I adjust my communication style based on my audience.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Verbal Expression",
    ),
    AssessmentQuestion(
      id: 23,
      text: "I ask clarifying questions to ensure I understand others correctly.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Verbal Expression",
    ),
    // Ability 8: Non-Verbal Communication
    AssessmentQuestion(
      id: 24,
      text: "I am aware of how my body language affects others.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Non-verbal Communication",
    ),
    AssessmentQuestion(
      id: 25,
      text: "I adjust my facial expressions and posture to match the tone of a conversation and the setting.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Non-verbal Communication",
    ),
    AssessmentQuestion(
      id: 26,
      text: "I intentionally use nonverbal gestures to enhance my verbal communication.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Non-verbal Communication",
    ),
    // Ability 9: Assertiveness
    AssessmentQuestion(
      id: 27,
      text: "It is easy for me to tell people what I think and want.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Assertiveness",
    ),
    AssessmentQuestion(
      id: 28,
      text: "I express my thoughts when I strongly believe in them.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Assertiveness",
    ),
    AssessmentQuestion(
      id: 29,
      text: "I stand up for my rights.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Assertiveness",
    ),
    AssessmentQuestion(
      id: 30,
      text: "I challenge people’s beliefs when I think they are wrong.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Assertiveness",
    ),
    // Ability 10: Conflict Management
    AssessmentQuestion(
      id: 31,
      text: "I remain calm, composed and able to de-escalate the situation when faced with conflict.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Conflict Management",
    ),
    AssessmentQuestion(
      id: 32,
      text: "I focus on finding mutually beneficial solutions in conflicts.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Conflict Management",
    ),
    AssessmentQuestion(
      id: 33,
      text: "I adapt my conflict resolution style based on the situation and parties involved.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Conflict Management",
    ),

    // ----------------------------------------------------
    // COMPETENCY 3: STRESS MANAGEMENT (Questions 34 - 52)
    // ----------------------------------------------------
    // Ability 11: Stress Tolerance
    AssessmentQuestion(
      id: 34,
      text: "I can solve problems even when I am upset.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Stress Tolerance",
    ),
    AssessmentQuestion(
      id: 35,
      text: "I am able to handle upsetting conversations and face emotional difficulties.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Stress Tolerance",
    ),
    AssessmentQuestion(
      id: 36,
      text: "I get overwhelmed very easily.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Stress Tolerance",
      isReverse: true,
    ),
    AssessmentQuestion(
      id: 37,
      text: "I can tolerate painful feelings and not avoid them.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Stress Tolerance",
    ),
    // Ability 12: Cognitive Flexibility
    AssessmentQuestion(
      id: 38,
      text: "I have difficulty adapting to change in both my personal and professional life.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Cognitive Flexibility",
      isReverse: true,
    ),
    AssessmentQuestion(
      id: 39,
      text: "I have a difficult time letting go of the past.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Cognitive Flexibility",
      isReverse: true,
    ),
    AssessmentQuestion(
      id: 40,
      text: "I can start new things and adjust my course when circumstances change.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Cognitive Flexibility",
    ),
    AssessmentQuestion(
      id: 41,
      text: "I find it hard to change my opinion about things.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Cognitive Flexibility",
      isReverse: true,
    ),
    // Ability 13: Emotional Regulation
    AssessmentQuestion(
      id: 42,
      text: "I can calm myself down when feeling overwhelmed or upset.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Emotional Regulation",
    ),
    AssessmentQuestion(
      id: 43,
      text: "I am able to manage stress and anxiety in a calm manner.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Emotional Regulation",
    ),
    AssessmentQuestion(
      id: 44,
      text: "I am not able to control my negative emotional responses.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Emotional Regulation",
      isReverse: true,
    ),
    // Ability 14: Social Resources
    AssessmentQuestion(
      id: 45,
      text: "I have people in my life who are supportive and encourage me to pursue my goals.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Social Resources",
    ),
    AssessmentQuestion(
      id: 46,
      text: "I have colleagues and/or mentors who offer helpful advice and guidance.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Social Resources",
    ),
    AssessmentQuestion(
      id: 47,
      text: "I feel unsupported, lonely, and unable to rely on anyone during difficult times.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Social Resources",
      isReverse: true,
    ),
    AssessmentQuestion(
      id: 48,
      text: "I am comfortable asking for help from friends or community members when needed.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Social Resources",
    ),
    // Ability 15: Optimism
    AssessmentQuestion(
      id: 49,
      text: "I generally expect positive outcomes in challenging situations.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Optimism",
    ),
    AssessmentQuestion(
      id: 50,
      text: "I believe that I can overcome obstacles and achieve my goals.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Optimism",
    ),
    AssessmentQuestion(
      id: 51,
      text: "I view failures as opportunities for growth and learning.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Optimism",
    ),
    AssessmentQuestion(
      id: 52,
      text: "I focus on the positive aspects of difficult situations.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Optimism",
    ),

    // ----------------------------------------------------
    // COMPETENCY 4: SPIRIT MANAGEMENT (Questions 53 - 70)
    // ----------------------------------------------------
    // Ability 16: Belief Influence
    AssessmentQuestion(
      id: 53,
      text: "My core values help guide my decisions during crises and adversity.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Belief Influence",
    ),
    AssessmentQuestion(
      id: 54,
      text: "My values — spiritual, or otherwise — help me find meaning in challenging situations.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Belief Influence",
    ),
    AssessmentQuestion(
      id: 55,
      text: "I integrate my values into my daily life to support my well-being and resilience.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Belief Influence",
    ),
    // Ability 17: Clarity
    AssessmentQuestion(
      id: 56,
      text: "I understand my purpose in life and how it influences my goals.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Clarity",
    ),
    AssessmentQuestion(
      id: 57,
      text: "I can clearly articulate my core values and how they guide my decisions.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Clarity",
    ),
    AssessmentQuestion(
      id: 58,
      text: "I feel confident in the direction my life is taking based on my values and purpose.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Clarity",
    ),
    AssessmentQuestion(
      id: 59,
      text: "I use my spiritual belief system to reframe negative thoughts.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Clarity",
    ),
    // Ability 18: Energy Awareness
    AssessmentQuestion(
      id: 60,
      text: "I can easily identify physical and mental activities that boost my energy levels.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Energy Awareness",
    ),
    AssessmentQuestion(
      id: 61,
      text: "I can identify habits or routines that deplete my energy.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Energy Awareness",
    ),
    AssessmentQuestion(
      id: 62,
      text: "I regularly engage with activities or people that energize me.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Energy Awareness",
    ),
    AssessmentQuestion(
      id: 63,
      text: "I reflect on my daily experiences to understand what energizes or drains me.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Energy Awareness",
    ),
    // Ability 19: Community Building
    AssessmentQuestion(
      id: 64,
      text: "I consider what is best for the community when making a decision.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Community Building",
    ),
    AssessmentQuestion(
      id: 65,
      text: "I make an effort to stay in touch with friends and family regularly.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Community Building",
    ),
    AssessmentQuestion(
      id: 66,
      text: "I participate in group activities and actively contribute to build relationships.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Community Building",
    ),
    AssessmentQuestion(
      id: 67,
      text: "I often initiate conversations with new people in social settings.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Community Building",
    ),
    // Ability 20: Meaning Making
    AssessmentQuestion(
      id: 68,
      text: "I am able to make sense of my life experiences and find meaning in them.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Meaning Making",
    ),
    AssessmentQuestion(
      id: 69,
      text: "I am able to integrate difficult experiences into my overall life narrative.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Meaning Making",
    ),
    AssessmentQuestion(
      id: 70,
      text: "I am able to find meaning in my life during difficult times.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit Management",
      abilityName: "Meaning Making",
    ),

    // ----------------------------------------------------
    // COMPETENCY 5: EXECUTIVE FUNCTION (Questions 71 - 86)
    // ----------------------------------------------------
    // Ability 21: Planning
    AssessmentQuestion(
      id: 71,
      text: "I break down large tasks into manageable steps.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Planning",
    ),
    AssessmentQuestion(
      id: 72,
      text: "I create, review and adjust my plans realistically, to achieve long-term objectives.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Planning",
    ),
    AssessmentQuestion(
      id: 73,
      text: "I plan my work to avoid rushing to complete things.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Planning",
    ),
    AssessmentQuestion(
      id: 74,
      text: "I use organizational tools (like calendars or planners) to stay on track and manage my time efficiently.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Planning",
    ),
    // Ability 22: Prioritizing
    AssessmentQuestion(
      id: 75,
      text: "I prioritize tasks based on their urgency and importance.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Prioritizing",
    ),
    AssessmentQuestion(
      id: 76,
      text: "I delegate tasks effectively to free up time for high-priority activities.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Prioritizing",
    ),
    AssessmentQuestion(
      id: 77,
      text: "I avoid multitasking when it might compromise the quality of important tasks.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Prioritizing",
    ),
    // Ability 23: Motivation
    AssessmentQuestion(
      id: 78,
      text: "I approach my work and personal life with enthusiasm, seeing challenges as opportunities for growth.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Motivation",
    ),
    AssessmentQuestion(
      id: 79,
      text: "I find most things in life interesting.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Motivation",
    ),
    AssessmentQuestion(
      id: 80,
      text: "I am motivated to work on projects even when the external rewards are not immediate.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Motivation",
    ),
    // Ability 24: Attention Span
    AssessmentQuestion(
      id: 81,
      text: "I can focus on a task for extended periods without distraction.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Attention Span",
    ),
    AssessmentQuestion(
      id: 82,
      text: "I can refocus quickly after interruptions or breaks.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Attention Span",
    ),
    AssessmentQuestion(
      id: 83,
      text: "I am able to maintain attention even when tasks become repetitive or routine.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Attention Span",
    ),
    // Ability 25: Organization
    AssessmentQuestion(
      id: 84,
      text: "I have a system for organizing my files and items so I can find what I need instantly.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Organization",
    ),
    AssessmentQuestion(
      id: 85,
      text: "I use tools to effectively organize my tasks and projects to meet deadlines.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Organization",
    ),
    AssessmentQuestion(
      id: 86,
      text: "I regularly review and adjust my organizational systems as needed.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Function",
      abilityName: "Organization",
    ),

    // ----------------------------------------------------
    // COMPETENCY 6: DECISION MAKING (Questions 87 - 102)
    // ----------------------------------------------------
    // Ability 26: Processing Speed
    AssessmentQuestion(
      id: 87,
      text: "I can quickly understand complex information and apply it effectively.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Processing Speed",
    ),
    AssessmentQuestion(
      id: 88,
      text: "I can distinguish between relevant and irrelevant information.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Processing Speed",
    ),
    AssessmentQuestion(
      id: 89,
      text: "I can make quick decisions without feeling stalled or paralyzed.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Processing Speed",
    ),
    // Ability 27: Impulse Control
    AssessmentQuestion(
      id: 90,
      text: "I think before I speak or act.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Impulse Control",
    ),
    AssessmentQuestion(
      id: 91,
      text: "I can stop myself even when I know the consequence of my action will be negative.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Impulse Control",
    ),
    AssessmentQuestion(
      id: 92,
      text: "I listen to people without interrupting when they are talking.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Impulse Control",
    ),
    AssessmentQuestion(
      id: 93,
      text: "I consider alternatives to a decision before acting.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Impulse Control",
    ),
    // Ability 28: Reality Testing
    AssessmentQuestion(
      id: 94,
      text: "I present information accurately without exaggerating.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Reality Testing",
    ),
    AssessmentQuestion(
      id: 95,
      text: "I stay focused on reality rather than getting carried away by fantasies.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Reality Testing",
    ),
    AssessmentQuestion(
      id: 96,
      text: "My truth often matches what others believe.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Reality Testing",
    ),
    // Ability 29: Abstraction
    AssessmentQuestion(
      id: 97,
      text: "I can identify patterns or similarities across different situations.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Abstraction",
    ),
    AssessmentQuestion(
      id: 98,
      text: "I am able to apply general principles to specific problems and vice versa.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Abstraction",
    ),
    AssessmentQuestion(
      id: 99,
      text: "I recognize when a solution from one context can be applied to another.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Abstraction",
    ),
    // Ability 30: Problem Solving
    AssessmentQuestion(
      id: 100,
      text: "I select the best course of action based on a balance of data and wisdom.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Problem Solving",
    ),
    AssessmentQuestion(
      id: 101,
      text: "I am open to dealing with new situations and problems.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Problem Solving",
    ),
    AssessmentQuestion(
      id: 102,
      text: "I can think of several approaches to handle situations that require solutions.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Problem Solving",
    ),
  ];

  /// Psychometric interpretations from the approved specification
  static final Map<String, AbilityInterpretation> interpretations = {
    'Emotional Awareness': const AbilityInterpretation(
      abilityName: 'Emotional Awareness',
      competencyKey: 'SELF_MANAGEMENT',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You may struggle to recognize your emotions or understand how these emotions influence your behavior. You might find it challenging to articulate your feelings or empathize with others.',
      lowImplications: 'Difficulty in managing stress, poor decision-making, and strained interpersonal relationships. You may benefit from developing self-awareness and learning to express your emotions effectively.',
      mediumCharacteristics: 'You can generally identify your emotions and understand their impact on your behavior to some extent. However, you may still struggle with emotional regulation or fully empathizing with others.',
      mediumImplications: 'While you manage your emotions somewhat effectively, you may occasionally struggle with stress or conflict. Stronger emotional regulation can enhance your relationships.',
      highCharacteristics: 'You are adept at recognizing and understanding your emotions, as well as those of others. You effectively manage your emotions, leading to sound decisions and strong relationships.',
      highImplications: 'You tend to handle stress well, communicate effectively, and foster supportive environments. You excel in leadership roles requiring empathy.',
    ),
    'Boundary Awareness': const AbilityInterpretation(
      abilityName: 'Boundary Awareness',
      competencyKey: 'SELF_MANAGEMENT',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You may struggle to recognize or enforce your boundaries. You might frequently feel drained, overwhelmed, or taken advantage of in relationships, sacrificing your own needs for others.',
      lowImplications: 'Hinders self-awareness, increases emotional strain, and reduces overall interpersonal effectiveness.',
      mediumCharacteristics: 'You are aware of the importance of boundaries and have started implementing them, but might still struggle with consistency or enforcement.',
      mediumImplications: 'Reflects developing self-awareness and assertiveness, though further growth in recognizing your needs will help safeguard your well-being.',
      highCharacteristics: 'You demonstrate strong boundary awareness. You can clearly identify your limits, communicate them effectively, and enforce them consistently.',
      highImplications: 'Enhances your emotional intelligence by fostering self-awareness, assertiveness, empathy, and emotional regulation, contributing directly to leadership resilience.',
    ),
    'Self-Confidence': const AbilityInterpretation(
      abilityName: 'Self-Confidence',
      competencyKey: 'SELF_MANAGEMENT',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You may struggle with self-doubt and insecurity. You might have difficulty expressing yourself assertively or making decisions, hesitating to accept praise or reinforcement.',
      lowImplications: 'Can cause performance anxiety, requiring greater emotional regulation and affecting your leadership potential.',
      mediumCharacteristics: 'You have a moderate level of self-confidence. You feel confident in some familiar areas but hesitate in unfamiliar or challenging ones.',
      mediumImplications: 'Allows for reasonable emotional management and independence, though there is clear room for growth in high-stakes environments.',
      highCharacteristics: 'You demonstrate grounded self-confidence. You trust your abilities, express yourself assertively, and handle setbacks with poise.',
      highImplications: 'Contributes to superior emotional regulation, assertive self-expression, and positive interpersonal influence.',
    ),
    'Self-Actualization': const AbilityInterpretation(
      abilityName: 'Self-Actualization',
      competencyKey: 'SELF_MANAGEMENT',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You may struggle to realize your potential and find meaning in daily activities. Setting and pursuing personal goals may feel elusive.',
      lowImplications: 'Can indicate lower motivation and independence, which hinders emotional growth and self-confidence.',
      mediumCharacteristics: 'You are working towards personal growth but still face challenges in fully realizing your potential or maintaining sustained purpose.',
      mediumImplications: 'Suggests growing independence in your values and an ability to make meaning, with room for improvement in sustained goal pursuit.',
      highCharacteristics: 'You have a clear sense of purpose, actively pursue continuous growth, and feel deeply fulfilled in your daily pursuits.',
      highImplications: 'Significantly enhances self-awareness, intrinsic motivation, and overall psychological resilience.',
    ),
    'Independence': const AbilityInterpretation(
      abilityName: 'Independence',
      competencyKey: 'SELF_MANAGEMENT',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You may struggle with autonomous decision-making, relying heavily on others for guidance, reassurance, and validation.',
      lowImplications: 'Hinders self-management, authentic communication, self-confidence, and autonomous leadership.',
      mediumCharacteristics: 'You can make decisions independently but still seek external validation in uncertain or high-pressure situations.',
      mediumImplications: 'Allows reasonable self-reliance while maintaining healthy interdependence with peers and mentors.',
      highCharacteristics: 'You are comfortable making decisions autonomously, trust your own judgment, and take accountability for outcomes.',
      highImplications: 'Contributes directly to high emotional self-reliance, decisiveness, and calm executive presence.',
    ),
    'Empathy': const AbilityInterpretation(
      abilityName: 'Empathy',
      competencyKey: 'INTERPERSONAL_MANAGEMENT',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You may struggle to recognize or attune to others\' emotions, finding it difficult to understand perspectives different from your own.',
      lowImplications: 'Can strain collaborative relationships, impede conflict resolution, and limit social awareness.',
      mediumCharacteristics: 'You have a healthy ability to understand others\' feelings and recognize overt emotions, but may occasionally miss subtle non-verbal cues.',
      mediumImplications: 'Allows for dependable social interaction and constructive teamwork in familiar environments.',
      highCharacteristics: 'You demonstrate acute attunement to emotional states and understand diverse perspectives with genuine care and healthy boundaries.',
      highImplications: 'Fosters psychological safety, inspiring loyalty and deep rapport across diverse teams and relationships.',
    ),
    'Verbal Expression': const AbilityInterpretation(
      abilityName: 'Verbal Expression',
      competencyKey: 'INTERPERSONAL_MANAGEMENT',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You may struggle to articulate your thoughts, needs, or emotions clearly, leading to frequent misunderstandings.',
      lowImplications: 'Can hinder conflict resolution, clarity of expectations, and personal or professional influence.',
      mediumCharacteristics: 'You express yourself effectively in standard situations but may struggle with precision or adaptability under high pressure.',
      mediumImplications: 'Manages most communication tasks well; refining active listening and nuance will unlock greater impact.',
      highCharacteristics: 'You express complex thoughts, boundaries, and emotions with poise, clarity, and respect, effortlessly adapting to any audience.',
      highImplications: 'Directly supports executive presence, team alignment, and persuasive, empathetic leadership.',
    ),
    'Non-verbal Communication': const AbilityInterpretation(
      abilityName: 'Non-verbal Communication',
      competencyKey: 'INTERPERSONAL_MANAGEMENT',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You may struggle to convey emotions or intentions through posture, facial expressions, or vocal tone, occasionally appearing disengaged.',
      lowImplications: 'Can make establishing trust and authentic rapport more difficult in interpersonal settings.',
      mediumCharacteristics: 'You generally convey intentions accurately but may not always do so consistently in high-stakes or emotionally charged settings.',
      mediumImplications: 'Good everyday rapport; practicing intentional presence will strengthen non-verbal alignment.',
      highCharacteristics: 'You are highly attuned to body language, tone, and expressions—both your own and others\'—fostering trust and warmth.',
      highImplications: 'Excels in cross-cultural interactions, conflict de-escalation, and high-impact interpersonal engagements.',
    ),
    'Assertiveness': const AbilityInterpretation(
      abilityName: 'Assertiveness',
      competencyKey: 'INTERPERSONAL_MANAGEMENT',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You often hesitate to state your needs, opinions, or boundaries clearly, fearing friction or conflict.',
      lowImplications: 'Can lead to resentment, compromised personal boundaries, and missed opportunities to advocate for what matters.',
      mediumCharacteristics: 'You can express yourself but may experience moments of passivity or hesitation when dealing with dominant personalities.',
      mediumImplications: 'Effective in supportive environments; deliberate practice will build unwavering confidence in critical conversations.',
      highCharacteristics: 'You articulate your needs, beliefs, and boundaries with calm clarity, respect, and conviction.',
      highImplications: 'Commands natural respect, maintains healthy boundaries, and resolves interpersonal tensions constructively.',
    ),
    'Conflict Management': const AbilityInterpretation(
      abilityName: 'Conflict Management',
      competencyKey: 'INTERPERSONAL_MANAGEMENT',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You may avoid disagreements altogether or react with heightened friction, struggling to de-escalate emotional tension.',
      lowImplications: 'Unresolved tensions linger, causing relational friction and missed opportunities for mutual alignment.',
      mediumCharacteristics: 'You address conflicts when necessary and seek fair resolutions, though maintaining composure in tense moments takes effort.',
      mediumImplications: 'Resolves everyday friction; developing de-escalation techniques will elevate your leadership under pressure.',
      highCharacteristics: 'You remain grounded and calm during disputes, actively de-escalating tension and crafting mutually beneficial outcomes.',
      highImplications: 'Transforms conflict into collaborative breakthroughs, fostering enduring trust and high team morale.',
    ),
    'Stress Tolerance': const AbilityInterpretation(
      abilityName: 'Stress Tolerance',
      competencyKey: 'STRESS_MANAGEMENT',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You easily feel overwhelmed by mounting demands, experiencing acute emotional fatigue and difficulty focusing.',
      lowImplications: 'Can trigger early burnout, reactive decisions, and diminished well-being under sustained pressure.',
      mediumCharacteristics: 'You manage everyday stressors effectively but experience vulnerability during prolonged or unpredictable crises.',
      mediumImplications: 'Functions well with standard routines; adopting proactive recovery habits will safeguard resilience.',
      highCharacteristics: 'You stay mentally clear, grounded, and focused even as pressure mounts, viewing adversity as a challenge to master.',
      highImplications: 'A steady anchor in turbulent times, inspiring calm confidence and sustained high performance.',
    ),
    'Cognitive Flexibility': const AbilityInterpretation(
      abilityName: 'Cognitive Flexibility',
      competencyKey: 'STRESS_MANAGEMENT',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You find unexpected change jarring and hold tightly to past habits, resisting alternative viewpoints or sudden pivots.',
      lowImplications: 'Limits adaptability in fast-evolving environments and increases friction during organizational transitions.',
      mediumCharacteristics: 'You adapt to changes with some deliberation, though letting go of preferred routines takes conscious effort.',
      mediumImplications: 'Navigates planned transitions well; strengthening cognitive agility will boost responsiveness to sudden shifts.',
      highCharacteristics: 'You embrace change with an agile mindset, effortlessly pivoting strategies and reframing assumptions in real time.',
      highImplications: 'Thrives in ambiguous, fast-paced environments, leading transformative initiatives with ease.',
    ),
    'Emotional Regulation': const AbilityInterpretation(
      abilityName: 'Emotional Regulation',
      competencyKey: 'STRESS_MANAGEMENT',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You experience abrupt emotional swings or impulsive reactions, finding it hard to calm your nervous system after a trigger.',
      lowImplications: 'Can damage interpersonal trust, cloud strategic judgment, and deplete vital energy reserves.',
      mediumCharacteristics: 'You manage emotional responses well under ordinary conditions, but intense pressure can occasionally trigger overreactions.',
      mediumImplications: 'Maintaining regular mindfulness and breathwork will solidify your emotional equilibrium.',
      highCharacteristics: 'You modulate the intensity of emotional responses with mastery, remaining centered in any storm.',
      highImplications: 'Exemplifies executive presence, emotional stability, and thoughtful, measured decision-making.',
    ),
    'Social Resources': const AbilityInterpretation(
      abilityName: 'Social Resources',
      competencyKey: 'STRESS_MANAGEMENT',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You lack a dependable support network or hesitate to reach out, often carrying burdens in isolation.',
      lowImplications: 'Heightens feelings of loneliness and reduces resilience during challenging life chapters.',
      mediumCharacteristics: 'You have a support circle but may not actively activate it when facing complex or overwhelming circumstances.',
      mediumImplications: 'Reaching out more proactively will amplify both emotional relief and collaborative problem-solving.',
      highCharacteristics: 'You cultivate robust, mutually uplifting relationships that provide emotional grounding and wise counsel.',
      highImplications: 'Draws upon a rich ecosystem of relational support, multiplying resilience and collaborative success.',
    ),
    'Optimism': const AbilityInterpretation(
      abilityName: 'Optimism',
      competencyKey: 'STRESS_MANAGEMENT',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You tend to anticipate negative outcomes, focusing heavily on obstacles and potential failures.',
      lowImplications: 'Can dampen motivation, lower personal initiative, and create unnecessary anxiety.',
      mediumCharacteristics: 'You maintain a realistic, generally positive outlook, though setbacks can temporarily shake your confidence.',
      mediumImplications: 'Practicing gratitude and cognitive reframing will reinforce your long-term optimism.',
      highCharacteristics: 'You maintain an unshakeable belief in positive possibilities and treat every failure as invaluable data for growth.',
      highImplications: 'Inspires enthusiasm, fuels persistent effort, and cultivates resilient, hopeful environments.',
    ),
    'Belief Influence': const AbilityInterpretation(
      abilityName: 'Belief Influence',
      competencyKey: 'SPIRIT_MANAGEMENT',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'Your daily choices may feel disconnected from your deeper personal or spiritual values, creating ethical uncertainty.',
      lowImplications: 'Can erode authentic motivation, inner peace, and personal integrity over time.',
      mediumCharacteristics: 'You strive to live by your principles, though competing practical demands can occasionally cause compromise.',
      mediumImplications: 'Refining your core value hierarchy will bring greater alignment to everyday choices.',
      highCharacteristics: 'Your core values serve as an unwavering compass, guiding decisions during both crisis and calm.',
      highImplications: 'Commands high moral integrity, authentic purpose, and unwavering trust from others.',
    ),
    'Clarity': const AbilityInterpretation(
      abilityName: 'Clarity',
      competencyKey: 'SPIRIT_MANAGEMENT',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You feel foggy regarding your life purpose or long-term priorities, struggling to articulate what truly matters.',
      lowImplications: 'Leads to scattered energy, difficulty setting firm priorities, and chronic decision fatigue.',
      mediumCharacteristics: 'You understand your general direction but occasionally lose sight of priorities amidst everyday noise.',
      mediumImplications: 'Regular reflection and journaling will keep your long-term vision sharp and actionable.',
      highCharacteristics: 'You pierce through noise to see your true priorities, acting with deep conviction and purpose.',
      highImplications: 'Unlocks sharp focus, strategic foresight, and resolute execution aligned with your life purpose.',
    ),
    'Energy Awareness': const AbilityInterpretation(
      abilityName: 'Energy Awareness',
      competencyKey: 'SPIRIT_MANAGEMENT',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You push through fatigue without recognizing what depletes or recharges your physical and mental battery.',
      lowImplications: 'Leads to chronic exhaustion, emotional reactivity, and reduced productivity.',
      mediumCharacteristics: 'You notice when your energy drops, but often delay taking intentional restorative breaks.',
      mediumImplications: 'Establishing non-negotiable recovery rituals will keep your daily vitality consistent.',
      highCharacteristics: 'You masterfully monitor your internal vitality, knowing exactly when to sprint and when to rest.',
      highImplications: 'Sustains peak performance without burnout, maintaining vibrant physical and emotional energy.',
    ),
    'Community Building': const AbilityInterpretation(
      abilityName: 'Community Building',
      competencyKey: 'SPIRIT_MANAGEMENT',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You feel detached from broader community initiatives and rarely take the lead in bringing people together.',
      lowImplications: 'Misses opportunities to build social capital, belonging, and shared collective impact.',
      mediumCharacteristics: 'You contribute to group activities when invited, though initiating new networks is not your default habit.',
      mediumImplications: 'Taking occasional initiative in social or team gatherings will expand your connective leadership.',
      highCharacteristics: 'You naturally gather people into ecosystems of safety, belonging, and mutual growth.',
      highImplications: 'Fosters extraordinary culture, deep social trust, and purposeful collective achievement.',
    ),
    'Meaning Making': const AbilityInterpretation(
      abilityName: 'Meaning Making',
      competencyKey: 'SPIRIT_MANAGEMENT',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You struggle to make sense of painful setbacks, often feeling like life events are arbitrary or unfair.',
      lowImplications: 'Prolongs emotional distress and delays healing following difficult transitions.',
      mediumCharacteristics: 'You eventually extract wisdom from hardship, but sitting with discomfort initially is challenging.',
      mediumImplications: 'Deepening self-reflection will help you integrate adversity into your life story more smoothly.',
      highCharacteristics: 'You extract transformative wisdom from setbacks, seamlessly weaving adversity into a rich life narrative.',
      highImplications: 'Cultivates profound emotional resilience, philosophical depth, and wise mentorship.',
    ),
    'Planning': const AbilityInterpretation(
      abilityName: 'Planning',
      competencyKey: 'EXECUTIVE_FUNCTION',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You dive into tasks without structured steps, frequently scrambling at deadlines or missing key details.',
      lowImplications: 'Causes chronic stress, rushed outputs, and difficulty achieving complex long-term goals.',
      mediumCharacteristics: 'You create plans for important projects but may struggle to adapt them smoothly when unexpected roadblocks arise.',
      mediumImplications: 'Adopting agile planning and contingency buffers will elevate project outcomes.',
      highCharacteristics: 'You decompose complex objectives into structured, realistic milestones with contingency buffers.',
      highImplications: 'Ensures predictable execution, calm workflow management, and sustained project excellence.',
    ),
    'Prioritizing': const AbilityInterpretation(
      abilityName: 'Prioritizing',
      competencyKey: 'EXECUTIVE_FUNCTION',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You treat every incoming demand as urgent, becoming overwhelmed by trivial tasks while critical goals stall.',
      lowImplications: 'Wastes vital time on low-leverage activities and stalls strategic progress.',
      mediumCharacteristics: 'You know what is most important, but urgent interruptions can derail your daily focus.',
      mediumImplications: 'Protecting dedicated deep-work blocks will keep your high-priority goals on track.',
      highCharacteristics: 'You ruthlessly filter noise to focus on high-impact priorities, delegating or deferring low-value tasks.',
      highImplications: 'Maximizes high-leverage outcomes, minimizes overwhelm, and accelerates leadership goals.',
    ),
    'Motivation': const AbilityInterpretation(
      abilityName: 'Motivation',
      competencyKey: 'EXECUTIVE_FUNCTION',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You struggle to self-initiate work unless under immediate external pressure or deadline urgency.',
      lowImplications: 'Procrastination, inconsistent momentum, and frustration with delayed accomplishments.',
      mediumCharacteristics: 'You have good drive when projects are exciting, but routine or prolonged tasks test your staying power.',
      mediumImplications: 'Connecting routine duties to overarching core values will sustain your intrinsic drive.',
      highCharacteristics: 'You possess an intrinsic engine of enthusiasm, sustaining momentum even when external rewards are deferred.',
      highImplications: 'Achieves ambitious goals with relentless persistence, inspiring high enthusiasm in others.',
    ),
    'Attention Span': const AbilityInterpretation(
      abilityName: 'Attention Span',
      competencyKey: 'EXECUTIVE_FUNCTION',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You are easily pulled away by digital notifications or random thoughts, finding it hard to sustain deep focus.',
      lowImplications: 'Fragments mental stamina, increases error rates, and elongates completion times.',
      mediumCharacteristics: 'You maintain solid focus on engaging tasks, but repetitive or lengthy responsibilities invite distraction.',
      mediumImplications: 'Minimizing environmental interruptions will strengthen your cognitive focus muscle.',
      highCharacteristics: 'You lock deep attention onto critical tasks for extended periods, swiftly refocusing after interruptions.',
      highImplications: 'Enables high cognitive output, flow states, and rapid mastery of demanding material.',
    ),
    'Organization': const AbilityInterpretation(
      abilityName: 'Organization',
      competencyKey: 'EXECUTIVE_FUNCTION',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'Your files, workspace, or schedule are disorganized, causing lost items, missed deadlines, and mental clutter.',
      lowImplications: 'Creates friction in daily workflows and drains mental bandwidth on basic logistics.',
      mediumCharacteristics: 'You have working systems in place, but busy periods cause systems to fray until an intentional reset.',
      mediumImplications: 'Regular weekly organization reviews will prevent system breakdown during crunch times.',
      highCharacteristics: 'You maintain elegant, functional systems for your workspace, schedule, and digital assets.',
      highImplications: 'Removes operational friction, saves valuable time, and maintains mental clarity.',
    ),
    'Processing Speed': const AbilityInterpretation(
      abilityName: 'Processing Speed',
      competencyKey: 'DECISION_MAKING',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You feel overwhelmed by rapid streams of complex information, experiencing hesitation or analysis paralysis.',
      lowImplications: 'Slows down decision-making in time-sensitive situations and causes cognitive fatigue.',
      mediumCharacteristics: 'You analyze complex data well under standard conditions, but rapid-fire ambiguity slows your decision tempo.',
      mediumImplications: 'Framework-based thinking will accelerate synthesis in fast-paced scenarios.',
      highCharacteristics: 'You rapidly distill complex, ambiguous information into crystal-clear insights and decisive action.',
      highImplications: 'Excels in fast-moving, high-stakes environments where timely judgment is paramount.',
    ),
    'Impulse Control': const AbilityInterpretation(
      abilityName: 'Impulse Control',
      competencyKey: 'DECISION_MAKING',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You often act or speak on sudden impulses without considering downstream consequences.',
      lowImplications: 'Leads to regretful remarks, impulsive financial or relational moves, and damaged credibility.',
      mediumCharacteristics: 'You generally pause before acting, but acute stress or fatigue weakens your inhibitory control.',
      mediumImplications: 'Practicing a five-second pause before responding to high-stakes triggers will solidify self-control.',
      highCharacteristics: 'You possess a rock-solid pause between trigger and response, weighing long-term outcomes before acting.',
      highImplications: 'Prevents costly errors, protects relational trust, and models exemplary self-governance.',
    ),
    'Reality Testing': const AbilityInterpretation(
      abilityName: 'Reality Testing',
      competencyKey: 'DECISION_MAKING',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You allow subjective anxieties or wishful fantasies to distort your perception of objective reality.',
      lowImplications: 'Can lead to miscalculated risks, defensive misinterpretations, and poor strategic bets.',
      mediumCharacteristics: 'You usually see things as they are, but strong emotional investments can occasionally skew your objectivity.',
      mediumImplications: 'Seeking candid outside perspectives helps calibrate perception against reality.',
      highCharacteristics: 'You see reality with uncompromising clarity, separating verified facts from emotional projections.',
      highImplications: 'Grounds strategic decisions in truth, avoiding blind spots and unnecessary crises.',
    ),
    'Abstraction': const AbilityInterpretation(
      abilityName: 'Abstraction',
      competencyKey: 'DECISION_MAKING',
      minScore: 3,
      maxScore: 30,
      lowCharacteristics: 'You focus almost exclusively on narrow concrete details, struggling to see broader patterns or root causes.',
      lowImplications: 'Limits strategic innovation and makes transferring lessons across different domains challenging.',
      mediumCharacteristics: 'You grasp conceptual models well, but applying them to unfamiliar or messy scenarios takes effort.',
      mediumImplications: 'Studying cross-disciplinary metaphors will sharpen your high-level conceptual agility.',
      highCharacteristics: 'You swiftly identify underlying patterns, connect disparate concepts, and apply principles across domains.',
      highImplications: 'Powers visionary strategic thinking, creative problem-solving, and breakthrough innovation.',
    ),
    'Problem Solving': const AbilityInterpretation(
      abilityName: 'Problem Solving',
      competencyKey: 'DECISION_MAKING',
      minScore: 4,
      maxScore: 40,
      lowCharacteristics: 'You feel daunted when complex challenges arise, relying heavily on others or adopting reactive trial-and-error.',
      lowImplications: 'Can prolong stressful impasses and cause recurring systemic problems.',
      mediumCharacteristics: 'You resolve familiar problems methodically, though emotionally charged dilemmas test your analytical calm.',
      mediumImplications: 'Applying structured root-cause analysis will boost consistency in high-pressure problems.',
      highCharacteristics: 'You dismantle complex problems with a calm, systematic balance of rigorous data and emotional wisdom.',
      highImplications: 'A trusted problem solver who turns daunting crises into sustainable strategic victories.',
    ),
  };

  /// Calculates competency percentage scores (0 - 100) and ai_priority rankings (1 = lowest score).
  /// Normal item score: answer (1 - 10)
  /// Reverse item score (R): 11 - answer
  static List<Map<String, dynamic>> calculateScores(Map<int, int> answers) {
    // 1. Group items by ability
    final Map<String, List<double>> abilityRawScores = {};
    for (final q in questions) {
      final raw = answers[q.id] ?? 5; // default 5 if unanswered
      final effective = q.isReverse ? (11 - raw).toDouble() : raw.toDouble();
      abilityRawScores.putIfAbsent(q.abilityName, () => []).add(effective);
    }

    // 2. Average items to get ability score (out of 10)
    final Map<String, double> abilityScoresOutOf10 = {};
    for (final entry in abilityRawScores.entries) {
      final sum = entry.value.fold<double>(0.0, (acc, val) => acc + val);
      abilityScoresOutOf10[entry.key] = sum / entry.value.length;
    }

    // 3. Group ability scores by competency
    final Map<String, List<double>> competencyAbilityScores = {
      'SELF_MANAGEMENT': [],
      'INTERPERSONAL_MANAGEMENT': [],
      'STRESS_MANAGEMENT': [],
      'SPIRIT_MANAGEMENT': [],
      'EXECUTIVE_FUNCTION': [],
      'DECISION_MAKING': [],
    };

    final Set<String> seenAbilities = {};
    for (final q in questions) {
      if (seenAbilities.add(q.abilityName)) {
        competencyAbilityScores[q.competencyKey]!.add(abilityScoresOutOf10[q.abilityName]!);
      }
    }

    // 4. Compute competency percentage score (0 - 100)
    final List<Map<String, dynamic>> competencyScores = [];
    for (final comp in competencies) {
      final key = comp['key']!;
      final scores = competencyAbilityScores[key] ?? [];
      final avgOutOf10 = scores.isEmpty
          ? 5.0
          : (scores.fold<double>(0.0, (acc, val) => acc + val) / scores.length);
      final scorePercentage = double.parse((avgOutOf10 * 10).toStringAsFixed(1));
      competencyScores.add({
        'competency': key,
        'competency_name': comp['name'],
        'score': scorePercentage,
      });
    }

    // 5. Sort ascending by score -> Lowest score is ai_priority 1 (most urgent growth area)
    competencyScores.sort((a, b) => (a['score'] as double).compareTo(b['score'] as double));

    for (int i = 0; i < competencyScores.length; i++) {
      competencyScores[i]['ai_priority'] = i + 1;
    }

    return competencyScores;
  }

  // ---------------------------------------------------------------------------
  // UPDATED EQi-30 SHORT ITEM BANK (6 Competencies × 8 Items = 48 Items)
  // Scale: 1 = Not at all true of me, 10 = Very true of me, most of the time
  // Reverse scored items marked with isReverse: true (score = 11 - response)
  // ---------------------------------------------------------------------------
  static const List<AssessmentQuestion> shortQuestions = [
    // 1) Self Management (Items 1 - 8)
    // Focus: self-awareness, self-regard, independence, responsibility, and growth.
    AssessmentQuestion(
      id: 1,
      text: "I can usually name what I am feeling.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Self-Awareness",
    ),
    AssessmentQuestion(
      id: 2,
      text: "I understand what tends to trigger my reactions.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Self-Awareness",
    ),
    AssessmentQuestion(
      id: 3,
      text: "I feel basically secure in who I am.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Self-Regard",
    ),
    AssessmentQuestion(
      id: 4,
      text: "I take responsibility for my growth.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Responsibility & Growth",
    ),
    AssessmentQuestion(
      id: 5,
      text: "When I make mistakes, I can learn without collapsing into shame.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Resilience & Growth",
    ),
    AssessmentQuestion(
      id: 6,
      text: "I can make important choices without needing constant reassurance.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Independence",
    ),
    AssessmentQuestion(
      id: 7,
      text: "I do not understand why I react the way I do.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Self-Awareness",
      isReverse: true,
    ),
    AssessmentQuestion(
      id: 8,
      text: "I depend too much on others to tell me what I should do.",
      competencyKey: "SELF_MANAGEMENT",
      competencyName: "Self-Management",
      abilityName: "Independence",
      isReverse: true,
    ),

    // 2) Interpersonal Management (Items 9 - 16)
    // Focus: verbal communication, nonverbal communication, empathy, assertiveness, and conflict handling.
    AssessmentQuestion(
      id: 9,
      text: "I listen in a way that helps people feel heard.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Empathy & Listening",
    ),
    AssessmentQuestion(
      id: 10,
      text: "I usually notice how my words affect other people.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Verbal Communication",
    ),
    AssessmentQuestion(
      id: 11,
      text: "I can read nonverbal cues such as tone, facial expression, and body language.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Nonverbal Communication",
    ),
    AssessmentQuestion(
      id: 12,
      text: "My own facial expressions, tone, and body language usually match what I mean to communicate.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Nonverbal Communication",
    ),
    AssessmentQuestion(
      id: 13,
      text: "I can express what I think and feel clearly without becoming aggressive or passive.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Assertiveness",
    ),
    AssessmentQuestion(
      id: 14,
      text: "I try to understand other people before reacting.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Empathy",
    ),
    AssessmentQuestion(
      id: 15,
      text: "I can address conflict directly without avoiding it or escalating it.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Conflict Handling",
    ),
    AssessmentQuestion(
      id: 16,
      text: "When conflict starts, I either shut down or come in too hard.",
      competencyKey: "INTERPERSONAL_MANAGEMENT",
      competencyName: "Interpersonal Management",
      abilityName: "Conflict Handling",
      isReverse: true,
    ),

    // 3) Stress Management (Items 17 - 24)
    // Focus: stress tolerance, flexibility, recovery, and realistic optimism.
    AssessmentQuestion(
      id: 17,
      text: "When I get upset, I can usually recover without staying stuck for too long.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Recovery",
    ),
    AssessmentQuestion(
      id: 18,
      text: "I can function reasonably well even when life feels stressful.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Stress Tolerance",
    ),
    AssessmentQuestion(
      id: 19,
      text: "I can adjust when plans change unexpectedly.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Flexibility",
    ),
    AssessmentQuestion(
      id: 20,
      text: "I do not let frustration control my behavior too easily.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Frustration Control",
    ),
    AssessmentQuestion(
      id: 21,
      text: "I can usually find a workable next step when things go wrong.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Adaptive Coping",
    ),
    AssessmentQuestion(
      id: 22,
      text: "Even under stress, I can hold on to some hope.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Realistic Optimism",
    ),
    AssessmentQuestion(
      id: 23,
      text: "Stress quickly overwhelms my ability to think clearly.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Stress Tolerance",
      isReverse: true,
    ),
    AssessmentQuestion(
      id: 24,
      text: "Small changes can throw me off for a long time.",
      competencyKey: "STRESS_MANAGEMENT",
      competencyName: "Stress Management",
      abilityName: "Flexibility",
      isReverse: true,
    ),

    // 4) Spirit / Energy Management (Items 25 - 32)
    // Focus: energy awareness, restoration, limits, values, and meaning.
    AssessmentQuestion(
      id: 25,
      text: "I know which people, places, and activities drain my energy.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit / Energy Management",
      abilityName: "Energy Awareness",
    ),
    AssessmentQuestion(
      id: 26,
      text: "I know what genuinely restores me.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit / Energy Management",
      abilityName: "Restoration",
    ),
    AssessmentQuestion(
      id: 27,
      text: "I notice my limits before I hit full burnout.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit / Energy Management",
      abilityName: "Limits & Boundaries",
    ),
    AssessmentQuestion(
      id: 28,
      text: "My daily life includes things that give me meaning or purpose.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit / Energy Management",
      abilityName: "Meaning & Purpose",
    ),
    AssessmentQuestion(
      id: 29,
      text: "My values or beliefs help steady me when life gets hard.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit / Energy Management",
      abilityName: "Values Alignment",
    ),
    AssessmentQuestion(
      id: 30,
      text: "I know where my beliefs come from and how they affect my energy and spirit.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit / Energy Management",
      abilityName: "Belief Awareness",
    ),
    AssessmentQuestion(
      id: 31,
      text: "I do not make choices that protect my energy or my schedule.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit / Energy Management",
      abilityName: "Energy Protection",
      isReverse: true,
    ),
    AssessmentQuestion(
      id: 32,
      text: "Most of my life feels draining without enough renewal.",
      competencyKey: "SPIRIT_MANAGEMENT",
      competencyName: "Spirit / Energy Management",
      abilityName: "Renewal",
      isReverse: true,
    ),

    // 5) Executive Functioning (Items 33 - 40)
    // Focus: planning, prioritizing, organization (including space), initiation, shifting, and tracking.
    AssessmentQuestion(
      id: 33,
      text: "I can break big tasks into manageable steps.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Functioning",
      abilityName: "Planning",
    ),
    AssessmentQuestion(
      id: 34,
      text: "I usually know what to do first and what can wait.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Functioning",
      abilityName: "Prioritizing",
    ),
    AssessmentQuestion(
      id: 35,
      text: "I can stay organized enough to follow through on important tasks.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Functioning",
      abilityName: "Organization",
    ),
    AssessmentQuestion(
      id: 36,
      text: "I can keep my space clear enough to help me think, plan, and work effectively.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Functioning",
      abilityName: "Space Organization",
    ),
    AssessmentQuestion(
      id: 37,
      text: "I can get started on things even when I do not feel like it.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Functioning",
      abilityName: "Task Initiation",
    ),
    AssessmentQuestion(
      id: 38,
      text: "I can shift gears when a plan is not working.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Functioning",
      abilityName: "Cognitive Shifting",
    ),
    AssessmentQuestion(
      id: 39,
      text: "I can keep track of what I need to do without losing the thread.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Functioning",
      abilityName: "Task Tracking",
    ),
    AssessmentQuestion(
      id: 40,
      text: "I often know what I should do but cannot get myself to start.",
      competencyKey: "EXECUTIVE_FUNCTION",
      competencyName: "Executive Functioning",
      abilityName: "Task Initiation",
      isReverse: true,
    ),

    // 6) Decision Making (Items 41 - 48)
    // Focus: information processing, working memory, use of past experience, impulse control, reality testing, objectivity, problem solving, and pattern recognition.
    AssessmentQuestion(
      id: 41,
      text: "I can take in new information without getting mentally overloaded too quickly.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Information Processing",
    ),
    AssessmentQuestion(
      id: 42,
      text: "I can hold important details in mind while comparing options.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Working Memory",
    ),
    AssessmentQuestion(
      id: 43,
      text: "I can use past experiences to help me understand what is happening now.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Experience Application",
    ),
    AssessmentQuestion(
      id: 44,
      text: "I can slow myself down before reacting impulsively.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Impulse Control",
    ),
    AssessmentQuestion(
      id: 45,
      text: "I can separate facts from assumptions when making decisions.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Reality Testing",
    ),
    AssessmentQuestion(
      id: 46,
      text: "I can stay objective even when I feel strongly about something.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Objectivity",
    ),
    AssessmentQuestion(
      id: 47,
      text: "I can work through problems instead of avoiding them or reacting blindly.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Problem Solving",
    ),
    AssessmentQuestion(
      id: 48,
      text: "I can pull patterns and lessons from new and old experiences.",
      competencyKey: "DECISION_MAKING",
      competencyName: "Decision Making",
      abilityName: "Pattern Recognition",
    ),
  ];

  /// Calculates competency scores for the 48-item Short Assessment.
  /// For each competency:
  /// - Reverse score items marked (R): score = 11 - response
  /// - Average the 8 item scores to get a 1.0–10.0 score (and 0-100 percentage)
  /// - Map to official bands:
  ///   8.0–10.0 = strength
  ///   6.5–7.9 = generally solid
  ///   5.0–6.4 = mixed / inconsistent
  ///   < 5.0 = growth area
  static List<Map<String, dynamic>> calculateShortScores(Map<int, int> answers) {
    final Map<String, List<double>> compScores = {
      'SELF_MANAGEMENT': [],
      'INTERPERSONAL_MANAGEMENT': [],
      'STRESS_MANAGEMENT': [],
      'SPIRIT_MANAGEMENT': [],
      'EXECUTIVE_FUNCTION': [],
      'DECISION_MAKING': [],
    };

    for (final q in shortQuestions) {
      final raw = answers[q.id] ?? 5;
      final effective = q.isReverse ? (11 - raw).toDouble() : raw.toDouble();
      compScores[q.competencyKey]?.add(effective);
    }

    final List<Map<String, dynamic>> results = [];
    for (final comp in competencies) {
      final key = comp['key']!;
      final items = compScores[key] ?? [];
      final avgOutOf10 = items.isEmpty
          ? 5.0
          : (items.fold<double>(0.0, (acc, val) => acc + val) / items.length);
      final scorePct = double.parse((avgOutOf10 * 10).toStringAsFixed(1));

      String band;
      if (avgOutOf10 >= 8.0) {
        band = 'strength';
      } else if (avgOutOf10 >= 6.5) {
        band = 'generally solid';
      } else if (avgOutOf10 >= 5.0) {
        band = 'mixed / inconsistent';
      } else {
        band = 'growth area';
      }

      results.add({
        'competency': key,
        'competency_name': comp['name'],
        'score': scorePct,
        'average_score': double.parse(avgOutOf10.toStringAsFixed(2)),
        'band': band,
      });
    }

    // Sort ascending by score -> lowest score gets priority 1 (primary growth focus)
    results.sort((a, b) => (a['score'] as double).compareTo(b['score'] as double));
    for (int i = 0; i < results.length; i++) {
      results[i]['ai_priority'] = i + 1;
    }
    return results;
  }
}
