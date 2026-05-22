import '../../shared/models/ability.dart';
import '../../shared/models/competency.dart';

class AppData {
  // Competencies Data
  static List<Competency> getCompetencies() {
    return [
      Competency(
        id: 'self_management',
        title: 'Self-Management',
        description: 'Emotions · Confidence · Boundaries',
        emoji: '🧠',
        percentage: 42,
        status: 'Needs Attention',
        color: '0xFF43BDC7',
        abilities: [
          'emotional_awareness',
          'boundary_awareness',
          'self_confidence',
          'self_actualization',
          'independence',
        ],
      ),
      Competency(
        id: 'stress_management',
        title: 'Stress Management',
        description: 'Resilience · Flexibility · Optimism',
        emoji: '🌊',
        percentage: 55,
        status: 'Developing',
        color: '0xFF249FA9',
        abilities: [
          'stress_tolerance',
          'cognitive_flexibility',
          'emotional_regulation',
          'optimism',
          'social_resources',
        ],
      ),
      Competency(
        id: 'interpersonal',
        title: 'Interpersonal Management',
        description: 'Empathy · Communication · Conflict',
        emoji: '🤝',
        percentage: 65,
        status: 'Good',
        color: '0xFF43C76F',
        abilities: [
          'empathy',
          'verbal_expression',
          'non_verbal_communication',
          'assertiveness',
          'conflict_management',
        ],
      ),
      Competency(
        id: 'spirit',
        title: 'Spirit & Energy',
        description: 'Resilience · Flexibility · Optimism',
        emoji: '⚡',
        percentage: 78,
        status: 'Strong',
        color: '0xFFF37C21',
        abilities: [
          'belief_influence',
          'clarity',
          'energy_awareness',
          'community_building',
          'meaning_making',
        ],
      ),
      Competency(
        id: 'executive',
        title: 'Executive Functioning',
        description: 'Planning · Flexibility · Optimism',
        emoji: '🧭',
        percentage: 85,
        status: 'Strong',
        color: '0xFF96B6F0',
        abilities: [
          'planning',
          'prioritizing',
          'motivation',
          'attention_span',
          'organization',
        ],
      ),
      Competency(
        id: 'decision',
        title: 'Decision Making',
        description: 'Intuition · Logic · Wisdom',
        emoji: '🎯',
        percentage: 92,
        status: 'Strong',
        color: '0xFF6A95E2',
        abilities: [
          'processing_speed',
          'impulse_control',
          'reality_testing',
          'abstraction',
          'problem_solving',
        ],
      ),
    ];
  }

  // Abilities Data
  static List<Ability> getAbilitiesByCompetency(String competencyId) {
    switch (competencyId) {
      case 'self_management':
        return [
          Ability(
            id: 'emotional_awareness',
            title: 'Emotional Awareness',
            description: 'Notice and name your emotions in real time.',
            emoji: '🧠',
            status: 'Day 1/30',
            progress: 3,
            competency: 'self_management',
          ),
          Ability(
            id: 'boundary_awareness',
            title: 'Boundary Awareness',
            description: 'Know your limits and say no without guilt.',
            emoji: '🚧',
            status: 'Not started',
            progress: 0,
            competency: 'self_management',
          ),
          Ability(
            id: 'self_confidence',
            title: 'Self-Confidence',
            description: 'Trust your abilities under pressure.',
            emoji: '💪',
            status: 'Not started',
            progress: 0,
            competency: 'self_management',
          ),
          Ability(
            id: 'self_actualization',
            title: 'Self-Actualization',
            description: 'Move toward your best, not just survive.',
            emoji: '🌱',
            status: 'Not started',
            progress: 0,
            competency: 'self_management',
          ),
          Ability(
            id: 'independence',
            title: 'Independence',
            description: 'Decide for yourself without over-relying on approval.',
            emoji: '🦅',
            status: 'Not started',
            progress: 0,
            competency: 'self_management',
          ),
        ];
      
      case 'stress_management':
        return [
          Ability(
            id: 'stress_tolerance',
            title: 'Stress Tolerance',
            description: 'Stay functional when pressure is high.',
            emoji: '🧘',
            status: 'Not started',
            progress: 0,
            competency: 'stress_management',
          ),
          Ability(
            id: 'cognitive_flexibility',
            title: 'Cognitive Flexibility',
            description: 'Adapt your thinking when situations change.',
            emoji: '🧩',
            status: 'Not started',
            progress: 0,
            competency: 'stress_management',
          ),
          Ability(
            id: 'emotional_regulation',
            title: 'Emotional Regulation',
            description: 'Shape and respond to emotions over time.',
            emoji: '⚖️',
            status: 'Not started',
            progress: 0,
            competency: 'stress_management',
          ),
          Ability(
            id: 'optimism',
            title: 'Optimism',
            description: 'Find realistic hope even in hard times.',
            emoji: '🌟',
            status: 'Not started',
            progress: 0,
            competency: 'stress_management',
          ),
          Ability(
            id: 'social_resources',
            title: 'Social Resources',
            description: 'Track and manage what drains or fuels you.',
            emoji: '🤗',
            status: 'Not started',
            progress: 0,
            competency: 'stress_management',
          ),
        ];
      
      case 'interpersonal':
        return [
          Ability(
            id: 'empathy',
            title: 'Empathy',
            description: 'Understand others\' feelings accurately.',
            emoji: '💗',
            status: 'Not started',
            progress: 0,
            competency: 'interpersonal',
          ),
          Ability(
            id: 'verbal_expression',
            title: 'Verbal Expression',
            description: 'Say what you mean clearly.',
            emoji: '🗣️',
            status: 'Not started',
            progress: 0,
            competency: 'interpersonal',
          ),
          Ability(
            id: 'non_verbal_communication',
            title: 'Non-verbal Communication',
            description: 'Align your body language with your message.',
            emoji: '🎭',
            status: 'Not started',
            progress: 0,
            competency: 'interpersonal',
          ),
          Ability(
            id: 'assertiveness',
            title: 'Assertiveness',
            description: 'Ask for what you need without aggression.',
            emoji: '👥',
            status: 'Not started',
            progress: 0,
            competency: 'interpersonal',
          ),
          Ability(
            id: 'conflict_management',
            title: 'Conflict Management',
            description: 'Stay steady and solution-focused in conflict.',
            emoji: '🧘‍♂️',
            status: 'Not started',
            progress: 0,
            competency: 'interpersonal',
          ),
        ];
      
      case 'spirit':
        return [
          Ability(
            id: 'belief_influence',
            title: 'Belief Influence',
            description: 'Examine beliefs that shape your sense of meaning.',
            emoji: '🙏',
            status: 'Not started',
            progress: 0,
            competency: 'spirit',
          ),
          Ability(
            id: 'clarity',
            title: 'Clarity',
            description: 'Get clear on what you want in life and work.',
            emoji: '🔍',
            status: 'Not started',
            progress: 0,
            competency: 'spirit',
          ),
          Ability(
            id: 'energy_awareness',
            title: 'Energy Awareness',
            description: 'Pursue your highest potential consistently.',
            emoji: '💚',
            status: 'Not started',
            progress: 0,
            competency: 'spirit',
          ),
          Ability(
            id: 'community_building',
            title: 'Community Building',
            description: 'Create belonging and connection around you.',
            emoji: '🏘️',
            status: 'Not started',
            progress: 0,
            competency: 'spirit',
          ),
          Ability(
            id: 'meaning_making',
            title: 'Meaning Making',
            description: 'Build and use your support network wisely.',
            emoji: '🌍',
            status: 'Not started',
            progress: 0,
            competency: 'spirit',
          ),
        ];
      
      case 'executive':
        return [
          Ability(
            id: 'planning',
            title: 'Planning',
            description: 'Organize your time and tasks effectively.',
            emoji: '📋',
            status: 'Not started',
            progress: 0,
            competency: 'executive',
          ),
          Ability(
            id: 'prioritizing',
            title: 'Prioritizing',
            description: 'Stay on task despite distraction.',
            emoji: '🎯',
            status: 'Not started',
            progress: 0,
            competency: 'executive',
          ),
          Ability(
            id: 'motivation',
            title: 'Motivation',
            description: 'Make sound decisions under pressure.',
            emoji: '🎮',
            status: 'Not started',
            progress: 0,
            competency: 'executive',
          ),
          Ability(
            id: 'attention_span',
            title: 'Attention Span',
            description: 'Set goals that actually move you forward.',
            emoji: '🧠',
            status: 'Not started',
            progress: 0,
            competency: 'executive',
          ),
          Ability(
            id: 'organization',
            title: 'Organization',
            description: 'Complete what you start, reliably.',
            emoji: '📦',
            status: 'Not started',
            progress: 0,
            competency: 'executive',
          ),
        ];
      
      case 'decision':
        return [
          Ability(
            id: 'processing_speed',
            title: 'Processing Speed',
            description: 'Analyze situations clearly before acting.',
            emoji: '🧠',
            status: 'Not started',
            progress: 0,
            competency: 'decision',
          ),
          Ability(
            id: 'impulse_control',
            title: 'Impulse Control',
            description: 'Understand risk and make informed choices.',
            emoji: '🛑',
            status: 'Not started',
            progress: 0,
            competency: 'decision',
          ),
          Ability(
            id: 'reality_testing',
            title: 'Reality Testing',
            description: 'See situations from multiple angles.',
            emoji: '🔬',
            status: 'Not started',
            progress: 0,
            competency: 'decision',
          ),
          Ability(
            id: 'abstraction',
            title: 'Abstraction',
            description: 'Make decisions aligned with what matters to you.',
            emoji: '⚖️',
            status: 'Not started',
            progress: 0,
            competency: 'decision',
          ),
          Ability(
            id: 'problem_solving',
            title: 'Problem Solving',
            description: 'Work through challenges step by step.',
            emoji: '💡',
            status: 'Not started',
            progress: 0,
            competency: 'decision',
          ),
        ];
      
      default:
        return [];
    }
  }

  // Get all abilities
  static List<Ability> getAllAbilities() {
    final List<Ability> allAbilities = [];
    final competencies = getCompetencies();
    
    for (var competency in competencies) {
      allAbilities.addAll(getAbilitiesByCompetency(competency.id));
    }
    
    return allAbilities;
  }
}
