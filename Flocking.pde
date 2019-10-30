import java.util.Random;
Random rand = new Random();

public ArrayList<Bird> birds = new ArrayList<Bird>();
public ArrayList<Predator> predators = new ArrayList<Predator>();
public float[] parameters = new float[10];

void setup(){
	size(700, 700);
	noStroke();
	frameRate(30);
	fill(0);
	
	for(int i = 0; i < 200; i++){
		birds.add(createRandomBird());
	}
	updateParameters();
}

void draw(){
	background(255);
	for(Bird b : birds){
		b.updateVelocity();
		b.updatePosition();
		b.drawBird();
	}
	for(Predator p : predators){
		p.updateVelocity();
		p.updatePosition();
		p.drawBird();
	}
}

Bird createRandomBird(){
	int x = rand.nextInt(width);
	int y = rand.nextInt(height);
	float v_x = (float)rand.nextGaussian()*2;
	float v_y = (float)rand.nextGaussian()*2;
	PVector v = new PVector(v_x, v_y);
	Bird b = new Bird(x, y, v);
	return b;
}

PVector getClosestBird(Bird thisBird){
	PVector closestDisplacement = new PVector(width, height);
	for(Bird b : birds){
		PVector displacement = PVector.sub(b.position, thisBird.position);
		if(displacement.x > width/2){
			displacement.x -= width;
		}
		if(displacement.y > height/2){
			displacement.y -= height;
		}
		if(displacement.mag() < closestDisplacement.mag() && displacement.mag() > 0){
			closestDisplacement = displacement;
		}
	}
	return closestDisplacement;
}

PVector getClosestPredator(Bird thisBird){
	PVector closestDisplacement = new PVector(width, height);
	for(Predator p : predators){
		PVector displacement = PVector.sub(p.position, thisBird.position);
		if(displacement.x > width/2){
			displacement.x -= width;
		}
		if(displacement.y > height/2){
			displacement.y -= height;
		}
		if(displacement.mag() < closestDisplacement.mag() && displacement.mag() > 0){
			closestDisplacement = displacement;
		}
	}
	return closestDisplacement;
}

ArrayList<Bird> getNeighbors(Bird thisBird, float radius, float angle){
	ArrayList<Bird> toReturn = new ArrayList<Bird>();
	for(Bird b : birds){
		PVector displacement = PVector.sub(b.position, thisBird.position);
		if(displacement.x > width/2){
			displacement.x -= width;
		}
		if(displacement.y > height/2){
			displacement.y -= height;
		}
		if(displacement.mag() < radius && displacement.mag() > 0){
			if(Math.abs(displacement.heading() - thisBird.velocity.heading()) < angle/2){
				toReturn.add(b);
			}
		}
	}
	return toReturn;
}

void mouseClicked(){
	if(mouseButton == LEFT){
		predators.add(new Predator(createRandomBird()));
	}else if(mouseButton == RIGHT){
		if(predators.size() > 0){
			predators.remove(predators.size() - 1);
		}
	}else if(mouseButton == CENTER){
		updateParameters();
	}
}

void updateParameters(){
	BufferedReader input = createReader("Flocking Parameters.txt");
	
	try{
		for(int i = 0; i < 10; i++){
			String data = input.readLine();
			int colonIndex = data.indexOf(':');
			data = data.substring(colonIndex + 1, data.length()).trim();
			parameters[i] = Float.parseFloat(data);
		}

	}
	catch(IOException e){
		e.printStackTrace();
	}
	catch(RuntimeException e){
		e.printStackTrace();
	}
	finally{
		try{
			input.close();
		}
		catch(IOException e){
			e.printStackTrace();
		}
		catch(RuntimeException e){
			e.printStackTrace();
		}
	}
}