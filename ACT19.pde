// ACTIVIDAD 19 - PWD 7° 2° B
// Gráficos, Animaciones e Interactividad en Processing

// 🌟 Variables para el movimiento de la elipse
float x, y; // Coordenadas
float xSpeed = 3; // Velocidad X
float ySpeed = 2; // Velocidad Y
float diametro = 50;

// 🎨 Variables de color
float r = 255;
float g = 0;
float b = 0;

// 📷 Variables para las imágenes
PImage fondo;
PImage imagen;

// 🔢 Variables extras
int clicks = 0;
boolean mostrarExtra = false;

void setup() {
  size(800, 600);
  
  // Cargar imágenes (comentadas para que funcione sin archivos)
  // Si tenés las imágenes, descomentá estas líneas:
  // fondo = loadImage("fondo.jpg");
  // imagen = loadImage("imagen.png");
  
  // Posición inicial en el centro
  x = width / 2;
  y = height / 2;
}

void draw() {
  // Dibujar el fondo
  // Si tenés imagen de fondo, usá: background(fondo);
  // Sino, usamos un degradado personalizado:
  drawGradientBackground();
  
  // Mostrar imagen adicional (logo en esquina sup. derecha)
  // Si tenés imagen: image(imagen, width - 100, 10, 80, 80);
  // Sino, dibujamos un logo decorativo:
  drawLogo();
  
  // Dibujar la elipse que se mueve
  fill(r, g, b);
  noStroke();
  ellipse(x, y, diametro, diametro);
  
  //  Efecto de rastro/sombra
  fill(r, g, b, 50);
  ellipse(x - xSpeed*2, y - ySpeed*2, diametro*0.8, diametro*0.8);
  
  // Actualizar posición
  x += xSpeed;
  y += ySpeed;
  
  // Rebote contra bordes
  if (x > width - diametro/2 || x < diametro/2) {
    xSpeed *= -1;
  }
  if (y > height - diametro/2 || y < diametro/2) {
    ySpeed *= -1;
  }
  
  // Dibujar iniciales
  drawInitials();
  
  // Figura extra si se hizo click
  if (mostrarExtra) {
    drawExtraFigure();
  }
  
  // Mostrar contador de clicks
  fill(255);
  textSize(16);
  text("Clicks: " + clicks, 10, 30);
  text("Velocidad: " + nf(abs(xSpeed), 1, 1), 10, 50);
}

// Función para dibujar fondo degradado
void drawGradientBackground() {
  for (int i = 0; i < height; i++) {
    float inter = map(i, 0, height, 0, 1);
    color c = lerpColor(color(20, 24, 82), color(133, 76, 147), inter);
    stroke(c);
    line(0, i, width, i);
  }
}

// Función para dibujar logo decorativo
void drawLogo() {
  pushMatrix();
  translate(width - 60, 50);
  
  // Estrella decorativa
  fill(255, 215, 0);
  noStroke();
  beginShape();
  for (int i = 0; i < 10; i++) {
    float angle = TWO_PI / 10 * i;
    float r = (i % 2 == 0) ? 30 : 15;
    float px = cos(angle) * r;
    float py = sin(angle) * r;
    vertex(px, py);
  }
  endShape(CLOSE);
  
  popMatrix();
}

// Función para dibujar iniciales
void drawInitials() {
  stroke(255);
  strokeWeight(8);
  strokeCap(ROUND);
  fill(255, 200);
  
  // Letra T
  // Línea horizontal superior
  line(80, 150, 160, 150);
  // Línea vertical central
  line(120, 150, 120, 250);
  
  // Letra Z
  // Línea superior
  line(200, 150, 280, 150);
  // Diagonal
  line(280, 150, 200, 250);
  // Línea inferior
  line(200, 250, 280, 250);
  
  // Decoración extra con elipses
  fill(100, 200, 255, 150);
  noStroke();
  ellipse(120, 130, 20, 20);
  ellipse(240, 130, 20, 20);
  
  // Texto descriptivo
  fill(255);
  textSize(14);
  text("Mis Iniciales: T Z", 150, 290);
}

// Función para figura extra
void drawExtraFigure() {
  pushMatrix();
  translate(mouseX, mouseY);
  rotate(frameCount * 0.05);
  
  fill(255, 255, 0, 200);
  noStroke();
  
  // Dibuja una flor
  for (int i = 0; i < 8; i++) {
    pushMatrix();
    rotate(TWO_PI / 8 * i);
    ellipse(0, 20, 15, 30);
    popMatrix();
  }
  
  // Centro de la flor
  fill(255, 100, 100);
  ellipse(0, 0, 15, 15);
  
  popMatrix();
}

// Interactividad: click para cambiar color y comportamiento
void mousePressed() {
  // Cambiar color aleatorio
  r = random(255);
  g = random(255);
  b = random(255);
  
  // Incrementar velocidad gradualmente
  xSpeed *= 1.2;
  ySpeed *= 1.2;
  
  // Limitar velocidad máxima
  xSpeed = constrain(xSpeed, -8, 8);
  ySpeed = constrain(ySpeed, -8, 8);
  
  // Activar figura extra
  mostrarExtra = !mostrarExtra;
  
  // Contar clicks
  clicks++;
  
  // Efecto visual en el click
  diametro = 70; // La pelota crece temporalmente
}

// Volver al tamaño normal gradualmente
void mouseReleased() {
  diametro = 50;
}

// Interactividad con teclado
void keyPressed() {
  if (key == 'r' || key == 'R') {
    // Reset: volver al estado inicial
    x = width / 2;
    y = height / 2;
    xSpeed = 3;
    ySpeed = 2;
    r = 255;
    g = 0;
    b = 0;
    clicks = 0;
    mostrarExtra = false;
  }
  
  if (key == ' ') {
    // Espacio: cambiar dirección aleatoria
    xSpeed = random(-5, 5);
    ySpeed = random(-5, 5);
  }
}
