class Bird{
	PVector position;
	PVector velocity;
	
	Bird(){
		position = new PVector(0, 0);
		velocity = new PVector(0, 0);
	}
	
	Bird(int x_, int y_, PVector velocity_){
		position = new PVector(x_, y_);
		velocity = velocity_;
	}
	
	void updatePosition(){
		position.add(velocity);
		position.x = position.x % width;
		if(position.x < 0){
			position.x += width;
		}
		position.y = position.y % height;
		if(position.y < 0){
			position.y += height;
		}
	}
	
	void drawBird(){
		translate(position.x, height - position.y);
		rotate(-velocity.heading()-PI/2);
		triangle(0, 8, -3, -1, 3, -1);
		rotate(velocity.heading()+PI/2);
		translate(-position.x, -height + position.y);
	}
	
	void updateVelocity(){
		//avoid collision
		PVector closestDisplacement = getClosestBird(this, birds);
		PVector velocityChangeFromCollisionAviodance = closestDisplacement.setMag(1/closestDisplacement.mag());
		velocityChangeFromCollisionAviodance.mult(-1);
		
		//steer towards same heading as neighbors
		ArrayList<Bird> neighbors = getNeighbors(this, parameters[6], parameters[5]);
		PVector averageHeading = new PVector();
		for(Bird b : neighbors){
			averageHeading.add(b.velocity);
		}
		if(neighbors.size() > 0){
			averageHeading.div(neighbors.size());
		}
		float directionChangeFromHeadingMatching = averageHeading.heading() - velocity.heading();
		if(directionChangeFromHeadingMatching > PI){
			directionChangeFromHeadingMatching = TWO_PI - directionChangeFromHeadingMatching;
		}
		if(neighbors.size() == 0){
			directionChangeFromHeadingMatching = 0;
		}
		float magnitudeChangeFromHeadingMatching = averageHeading.mag() - velocity.mag();
		
		//steer towards average position of neighbors
		neighbors = getNeighbors(this, parameters[6], parameters[5]);
		PVector averageDisplacement = new PVector();
		for(Bird b : neighbors){
			PVector displacement = PVector.sub(b.position, position);
			if(displacement.x > width/2){
				displacement.x -= width;
			}
			if(displacement.y > height/2){
				displacement.y -= height;
			}
			averageDisplacement.add(displacement);
		}
		if(neighbors.size() > 0){
			averageDisplacement.div(neighbors.size());
		}else{
			averageDisplacement = new PVector(0, 0);			
		}
		
		//predator avoidance
		if(predators.size() > 0){
			PVector predatorDisplacement = getClosestBird(this, predators);
			PVector velocityChangeFromPredatorAviodance = predatorDisplacement.setMag(1/predatorDisplacement.mag());
			velocityChangeFromPredatorAviodance.mult(-1);
			velocity.add(velocityChangeFromPredatorAviodance.mult(parameters[0]));
		}
		
		velocity.add(velocityChangeFromCollisionAviodance.mult(parameters[1]));
		velocity.rotate(directionChangeFromHeadingMatching*parameters[2]);
		velocity.setMag(velocity.mag() + magnitudeChangeFromHeadingMatching*parameters[3]);
		velocity.add(averageDisplacement.mult(parameters[4]/parameters[6]));

		
		if(velocity.mag() > 5){
			velocity.setMag(velocity.mag() - (velocity.mag() - 5)*0.2);
		}
		if(velocity.mag() < 3){
			velocity.setMag(velocity.mag() + (3 - velocity.mag())*0.4);
		}
	}
}
