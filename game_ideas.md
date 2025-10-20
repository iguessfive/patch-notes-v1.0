Core Concept:
An FPS where a timer periodically switches between 3D and 2D modes. Your position relative to an object's origin point determines how objects transform.
3D → 2D Transition:

Your cardinal direction from origin (+X, -X, +Y, -Y, +Z, -Z) becomes the viewing axis
Objects project orthographically along that axis
Enemies outside the 2D camera view are culled/killed

2D → 3D Transition:

Objects restore their excluded axis positions
Objects rotate so the axis you were positioned along points up
Player repositioned via raycast to stay grounded

Key Mechanics:

Strategic positioning before switches to control how objects rotate
Culling enemies by positioning them out of the projection
Object transformation puzzles (tall pillar → long platform depending on viewing axis)
Continuous enemy/object state across dimensions

Example:
Move to +X before the switch → 2D phase → return to 3D, objects rotate so +X points up, player repositioned.
