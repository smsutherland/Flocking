Controls:
	LMB - add a predator
	RMB - remove a predator (based on first-in last-out behavior)
	MMB - update flocking parameters from "Flocking Parameters.txt"

change parameters in "data/Flocking Parameters.txt" to change how the birds fly
do not change "data/Default Flocking Parameters.txt". it exists only as a reference for returning "data/Flocking Parameters.txt" to normal values

Parameter List:
	Predator Avoidance - how strongly birds avoid predators
	Collision Avoidance - how strongly birds avoid colliding with one another
	Heading Matching - how strongly birds will change their direction to match the direction of birds around them
	Speed Matching - how strongly birds will change their speed to match the direction of birds around them
	Center Seeking - how strongly birds will try to move towards the average position of nearby birds
	Bird FOV - the angle, centered directly in front of it, each bird can see other birds in (0 - 6.28)
	Bird Sight Range - how far away birds can see
	Predator Attraction - how strongly predators will try to move towards nearby birds
	Predator Collision Avoidance - how strongly predators will avoid other predators
	Predator FOV - the angle, centered directly in front of it, each predator can see birds in (0 - 6.28)
	Predator Sight Range - how far away predators can see