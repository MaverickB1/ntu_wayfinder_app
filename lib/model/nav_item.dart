class NavItem {
  NavItem({required this.step, required this.instruction});

  final int step;
  final String instruction;
}

List<NavItem> navRoute1 = [
  NavItem(
      step: 1,
      instruction:
          'Are you at the entrance of TCT? Does this picture look familiar?'),
  NavItem(
      step: 2,
      instruction:
          'Facing the direction of the picture, walk straight for 25m until you spot LT7.'),
  NavItem(
      step: 3,
      instruction:
          'Take a right turn and walk straight for 50m until you spot the lift.'),
  NavItem(
      step: 4,
      instruction:
          'Take the lift down to L1. Turn right when you get off and walk straight for 25m until you spot ASE.'),
  NavItem(
      step: 5,
      instruction:
          'Walk through the corridor and exit at the other end until you spot the lift.'),
  NavItem(
      step: 6,
      instruction: 'Take the lift down to B1. Turn right when you get off.'),
  NavItem(step: 7, instruction: 'You have arrived at your destination.'),
];

List<NavItem> navRoute2 = [
  NavItem(
      step: 1, instruction: 'Continue walking straight for about 50 meters'),
  NavItem(step: 2, instruction: 'Take a left-turn over here'),
  NavItem(step: 3, instruction: 'Take a right-turn over here'),
  NavItem(step: 4, instruction: 'Take the stairs up to the floor on top'),
  NavItem(step: 5, instruction: 'Take the stairs down to the floor below'),
  NavItem(step: 6, instruction: 'Take the ramp down'),
  NavItem(step: 7, instruction: 'Take the ramp up'),
  NavItem(step: 8, instruction: 'Your destination is just up ahead'),
];
