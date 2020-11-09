Figura figura;
Figura figuraSiguiente;
Fondo fondo;
int nivel = 1;
boolean gameover;

void setup() {
  size(720, 690);
  figura = new Figura();
  figura.esLibre = true;
  figuraSiguiente = new Figura();
  fondo = new Fondo();
}

void draw() {
  background(#14C298);
  if(gameover){
    textSize(60);
    //
    fill(0);
    text("Gameover :(", 147, 252);
    fill(#FFFFFF);
    text("Gameover :(", 150, 250);
    //
    fill(0);
    text("Tu Puntaje: "+fondo.puntaje*100, 147, 347);
    fill(#FFFFFF);
    text("Tu Puntaje: "+fondo.puntaje*100, 150, 345);
    //
    fill(0);
    text("Para reiniciar"+'\n'+"presiona R", 147, 450);
    fill(#FFFFFF);
    text("Para reiniciar"+'\n'+"presiona R", 150, 448);
  }else{
    fondo.mostrar();
    cuadricula();//Dibuja la cuadrícula
    dibujarFiguras();
  }
}

void dibujarFiguras() {//función para que el draw() dibuje las figuras y sus métodos en el sketch
  figuraSiguiente.otros();
  figura.mostrarFigura();
  if(figura.verificarFondo(fondo)){
    figura.bajar(nivel);
  }else {
    figura.esLibre = false;
  }
  if(!figura.esLibre){
    fondo.impregnarFigura(figura); 
    figura = figuraSiguiente;
    figura.esLibre = true;
    figuraSiguiente = new Figura();
  }
}

void keyPressed(){
  if(keyCode == RIGHT){
    figura.moverFigura("RIGHT");
  }
  if(keyCode == LEFT){
    figura.moverFigura("LEFT");  
  }
  if(keyCode == DOWN) {
    figura.moverFigura("DOWN");  
  }
  if(keyCode == UP){
    figura.rotar();
    figura.rotar();
    figura.rotCont++;
  }
  if(keyCode == SHIFT){
    gameover = true; 
  }
  if(keyCode == 'R'){//la tecla P para reiniciar el juego
    setup();
    gameover = false;
  }
  //figura.rotCont++;
}


void cuadricula() {//Malla en el tablero
  stroke(#C4C4C4);
  for(int i=0; i<=12; i++){//líneas horizontales
    line(i*30, 0, i*30, 660);
    strokeWeight(1);
  }
  for(int j=0; j<=22; j++){//líneas verticales
    line(0, j*30, 360, j*30);
    strokeWeight(1);
  }
}
