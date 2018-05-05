import ddf.minim.*;

Minim minim;
AudioPlayer player;

int puntos=0;
int repinta=1;
int jugar=1;
float size;
int radio=30;
int radio_objetivo;
float posY;
float posX;

void setup(){
  size(900,600);
  cursor(CROSS);
  minim = new Minim(this);
  
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  player = minim.loadFile("Headshot.mp3");
}

void draw(){

  if (repinta==1 && jugar==1){
    
    dibujar_forma();
   
  }
  repinta=0;
}
void dibujar_forma(){
      background(0);
      //dibujar objetivos falsos.
      for(int i=0; i<=puntos; i++){
        size=random(20,50);
        fill(random(0,255),random(0,255), random(0,255));
        ellipse(random(100,800), random(100,500),size,size);

      }
      
      //objetivo verdadero
      
      radio_objetivo= radio-puntos;
      
      fill(250,0,0);
      posX=random(100,800);
      posY=random(100,500);
      ellipse(posX,posY,radio_objetivo, radio_objetivo); 
      
      fill(0,255,0);
      textAlign(CENTER);
      textSize(18);
      text("puntos:"+ puntos,width/2,25);
}
void mousePressed(){
  if(jugar==1){
   if(repinta==0){
    repinta=1;   
   }
    if(mouseX>posX-radio_objetivo && mouseX<posX+radio_objetivo && mouseY>posY-radio_objetivo && mouseY<posY+radio_objetivo){
      puntos+=1;
    }
    else{
      jugar=0;
    }
  }
}

void mouseReleased(){
   if ( player.isPlaying() )
  {
    player.pause();
  }
  // if the player is at the end of the file,
  // we have to rewind it before telling it to play again
  else if ( player.position() == player.length() )
  {
    player.rewind();
    player.play();
  }
  else
  {
    player.play();
  }
}