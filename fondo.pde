public class Fondo {
  private int [][][] colors;
  private int r,g,b;
  private int w;
  private int X, Y;
  private int puntaje = 0;

  
  public Fondo() {
    colors = new int [12][22][3];//colors[filas][columnas][r(0), g(1), b(2)]
    w = 30;//ancho y alto de cada bloque
  }
  
  public void mostrar() {// metodo para pintar un  cuadrado para todo X y Y usando RGB, en principio el fondo va a quedar con 22x12 bloques con color negro
    for(int i = 0; i < 12; i++) {
      for(int j = 0; j < 22 ; j++) {
        r = colors[i][j][0];
        g = colors[i][j][1];
        b = colors[i][j][2];
        fill(r,g,b);
        rect(i*w, j*w, w, w);
      }
    }
    for(int i = 0; i<22; i++){//se vuelve a pintar despues de borrar las lineas correspondientes
      if(comprobarLinea(i)) {
        borrarLineas(i);
      }
    }
  }
  
  public void impregnarFigura(Figura f){//dejar fija la figura en el fondo
    //obtener el X y Y de cada bloque
    for(int i = 0; i<4; i++) {
      X = f.figura[i][0];//X va a ser la coordenada x de cada cuadrado de la figura
      Y = f.figura[i][1];//Y va a ser la coordenada y de cda cuadrado de la figura
      
      colors[X][Y][0] = f.r;
      colors[X][Y][1] = f.g;
      colors[X][Y][2] = f.b;
    }
  }
  
  public boolean comprobarLinea(int fila) {//comprobar si hay una linea completa
    for(int i = 0; i < 12; i++) {//ciclo para los 12 bloques de ancho
      if(colors[i][fila][0] == 0 && colors[i][fila][1] == 0 && colors[i][fila][2] == 0) {//se comprueba si hay color, recordar que 0 es color negro
        return false;
      }
    }
    return true;
  }
  
  public void borrarLineas(int fila) { // borrar la linea completa
    puntaje++;//se aumenta el puntaje por cada linea borrada
    int[][][] nuevoFondo = new int [12][22][3];//matriz para el nuevo fondo
    for(int i = 0; i < 12; i++) {
      for(int j = 21; j > fila; j--) {
         for(int a = 0; a < 3; a++) {
           nuevoFondo[i][j][a] = colors[i][j][a]; 
         }
      }
      for(int r = fila; r >= 1; r--) {//ciclo para bajar las filas
        for(int j = 0; j < 12; j++) {//ciclo para bajar cada bloque
          nuevoFondo[j][r][0] = colors[j][r-1][0]; 
          nuevoFondo[j][r][1] = colors[j][r-1][1];
          nuevoFondo[j][r][2] = colors[j][r-1][2];
        }
      }
    }
    colors = nuevoFondo;// se pinta el nuevo fondo despues de eliminar y desplazar las filas hacia abajo
  }
}
