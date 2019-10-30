class Predator extends Bird{
	Predator(){
		position = new PVector(0, 0);
		velocity = new PVector(0, 0);
	}
	
	Predator(int x_, int y_, PVector velocity_){
		position = new PVector(x_, y_);
		velocity = velocity_;
	}
	
	Predator(Bird b){
		position = b.position;
		velocity = b.velocity;
	}
	
	void drawBird(){
		translate(position.x, height - position.y);
		rotate(-velocity.heading()-PI/2);
		fill(200, 0, 0);
		triangle(0, 10, -4, -2, 4, -2);
		fill(0);
		rotate(velocity.heading()+PI/2);
		translate(-position.x, -height + position.y);
	}
	
	void updateVelocity(){
		ArrayList<Bird> neighbors = getNeighbors(this, 200, 3*HALF_PI);
		
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
		
		velocity.add(averageDisplacement.mult(0.005));
				
		if(velocity.mag() > 5){
			velocity.setMag(velocity.mag() - (velocity.mag() - 5)*0.2);
		}
		if(velocity.mag() < 3){
			velocity.setMag(velocity.mag() + (3 - velocity.mag())*0.4);
		}
	}
}