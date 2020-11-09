public class Figura {
  ////////////////////////////
  //coordenadas de las figuras
  //[][]
  //[][] 
  private int[][] figura1 = {{0,0},{1,0},{0,1},{1,1}}; 
  
  //[][][][]
  private int[][] figura2 = {{0,0},{1,0},{2,0},{3,0}};
  
  //  []
  //[][][]
  private int[][] figura3 = {{0,1},{1,1},{1,0},{2,1}}; 
  
  //[][][]
  //    []
  private int[][] figura4 = {{0,0},{1,0},{2,0},{2,1}};
  
  //[][][]
  //[]
  private int[][] figura5 = {{0,0},{1,0},{2,0},{0,1}}; 
  
  //[][]
  //  [][]
  private int[][] figura6 = {{0,0},{1,1},{1,0},{2,1}}; 
  
  //  [][]
  //[][]
  private int[][] figura7 = {{0,1},{1,1},{1,0},{2,0}}; 
  //////////////////////////
  private int[][] figura, fO; // figura y figura Original
  private int r,g,b;//color rgb
  private int nf;// numero de figura
  private boolean esLibre;
  private int w;// para el ancho y alto de cada cuadrado
  private int cont;//contador
  private int rotCont;//contador de rotación
  private int X, Y;//coordenadas X y Y
  private int nivel;
  
  
  
  public Figura() {
    w = 30;
    nf = (int)random(7);//nf sera un número aleatorio de 0 a 7 para elegir la figura
    switch(nf){
     case 0:
       figura = figura1;
       r = 255;// color rgb = (255,251,0)
       g = 251;
       b = 0;
       break;
     case 1:
       figura = figura2;
       r = 0;// color rgb = (0,255,247)
       g = 255;
       b = 247;
       break;
     case 2:
       figura = figura3;
       r = 232;// color rgb = (232,0,255)
       g = 0;
       b = 255;
       break;
     case 3:
       figura = figura4;
       r = 255;// color rgb = (255,166,0)
       g = 166;
       b = 0;
       break;
     case 4:
       figura = figura5;
       r = 0;// color rgb = (0,85,255)
       g = 85;
       b = 255;
       break;
     case 5:
       figura = figura6;
       r = 255;// color rgb = (255,65,65)
       g = 65;
       b = 65;
       break;
     case 6:
       figura = figura7;
       r = 65;// color rgb = (65,255,88)
       g = 255;
       b = 88;
       break;
    }
    cont = 1;
    fO = figura;// se hacen dos figuras, fO para almacenarla al fondo, y figura para mostrar la siguiente
    rotCont = 0;
  }
  
  public void mostrarFigura() {//metodo para mostrar la figura en la pantalla
    stroke(0);
    fill(r,g,b);
    for(int i=0; i<4; i++) {// se hace cuatro veces porque si
      rect(figura[i][0]*w, figura[i][1]*w, w, w);
    }
  }
  
  public void bajar(int level){//metodo para la velocidad de la figura cuando baja
    if(cont % 50 == 0){
      moverFigura("DOWN");
    }
    cont++;
    
  }
  
  public boolean comprobarLimites(String dir){//metodo para determinar los limites cuando se desplaza la figura
     switch(dir){
       case "RIGHT": // limite lateral derecho
         for(int i = 0; i<4; i++) {
           if(figura[i][0] > 10) {//mayor a 10 porque son 12 bloques de ancho
             return false; 
           }
         }
         break;
       case "LEFT": // limite lateral izquierdo
         for(int i = 0; i<4; i++){
           if(figura[i][0] < 1) {//menor a 1 porque es del lado izquierdo 
             return false; 
           }
         }
         break;
       case "DOWN": // limite inferior
           for(int i = 0; i<4; i++) {
             if(figura[i][1] > 20) {//mayor a 20 porque son 22 bloques de alto
               esLibre = false;
               return false; 
             }
           }
           break; 
     }return true;
  }
  
  
  public void  moverFigura(String dir) {
    if(comprobarLimites(dir)){//comprueba los limites, si es true si se puede desplazar
      if(dir=="RIGHT") {
        for(int i = 0; i<4; i++) {
          figura[i][0]++;  //mover a la derecha, se le suma 1 a la coordenada x 
        }
      }
      if(dir=="LEFT") {
        for(int i = 0; i<4; i++) {
          figura[i][0]--; //mover a la izquierda, se le resta 1 a la coordenada x
        }
      }
      if(dir == "DOWN") {
        for(int i = 0; i<4; i++) {
          figura[i][1]++; //mover hacia abajo, se le suma 1 a la coordenada y  
        }
      }
    }
  }
  
  public void rotar() {// método para rotar la figura
    if(figura != figura1){//la unica figura que no rota es el cuadrado(figura1), no es necesario...
      int[][] rotacion = new int[4][2];//la nueva matriz para las coordenadas de las figuras despues de rotadas
      if(rotCont % 4 == 3) {//primera rotación
        for(int i = 0; i<4; i++){
          rotacion[i][0] = fO[i][1] - figura[1][0];
          rotacion[i][1] = -fO[i][0] - figura[1][1];
        }
      }else if(rotCont % 4 == 2) {//segunda rotación
        for(int i = 0; i<4; i++){
          rotacion[i][0] = -fO[i][0] - figura[1][0];
          rotacion[i][1] = -fO[i][1] - figura[1][1];
        }
      }else if(rotCont % 4 == 1) {//tercera rotación
        for(int i = 0; i<4; i++){
          rotacion[i][0] = -fO[i][1] - figura[1][0];
          rotacion[i][1] = fO[i][0] - figura[1][1]; 
        }
      }else if(rotCont % 4 == 0) {//cuarta rotación
        for(int i = 0; i<4; i++){
          rotacion[i][0] = fO[i][0] - figura[1][0];
          rotacion[i][1] = fO[i][1] - figura[1][1]; 
        }
      }
      figura = rotacion; // la figura pasa a ser una nueva figura pero con la rotacion
    }
  }
  
  public boolean verificarFondo(Fondo f){//metodo para comprobar si hay mas bloques abajo
     for(int i = 0; i < 4; i++){
       X = figura[i][0];
       Y = figura[i][1];
       if (X >= 0 && X <12 && Y >= 0 && Y < 21){
         for(int a = 0; a < 3; a++) {
           if(f.colors[X][Y+1][a] != 0) {
             return false;
           }
         }
       }
     }//verificar cada bloque
     return true;
  }
  
  public void otros() { //metodo para la parte derecha del sketch
    //muestra cual es la siguiente figura
    stroke(0);
    fill(0);
    for(int i=0; i<4; i++) {
      rect(figura[i][0]*w + 500, figura[i][1]*w + 250, w, w);
    }
    fill(r,g,b);
    for(int i=0; i<4; i++) {
      rect(figura[i][0]*w + 503, figura[i][1]*w + 248, w, w);
    }
    textSize(32);
    fill(0);
    text("Siguiente figura:", 422, 227);
    fill(#FFFFFF);
    text("Siguiente figura:", 425, 225);
    
    //Muestra el Puntaje
    fill(0);
    text("Puntaje: "+fondo.puntaje*100, 422, 400);
    fill(#FFFFFF);
    text("Puntaje: "+fondo.puntaje*100, 425, 398);
    
    //Muestra el nivel
    fill(0);
    text("Nivel: "+ nivel, 422, 450);
    fill(#FFFFFF);
    text("Nivel: "+ nivel, 425, 448);
    
    //SHIFT para finalizar
    fill(0);
    text("Presiona SHIFT" + '\n'+ "para finalizar", 422, 525);
    fill(#FFFFFF);
    text("Presiona SHIFT" + '\n'+ "para finalizar", 425, 523);
  }
}
