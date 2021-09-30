HalfHexFractal l;

void setup(){
    size(1920,1080);
}
class HalfHexFractal {
    PVector start;       // A PVector for the start
    PVector end;         // A PVector for the end
    ArrayList<HalfHexLine> lines;   // A list to keep track of all the lines
    int maxDepth;

    HalfHexFractal(int md) {
        int length = 500;
        int offset = length/2;
        start = new PVector(width/2-offset,height/2);
        end = new PVector(width/2+offset,height/2);
        lines = new ArrayList<HalfHexLine>();
        maxDepth = md;
        generateFractal(0);
    }

    ArrayList<HalfHexLine> generateHalfHex(HalfHexLine line){
        ArrayList<HalfHexLine> newlines = new ArrayList<HalfHexLine>();
        PVector leftV = line.bottomUpPoint();
        PVector midV = line.upMidPoint(leftV);
        PVector rightV = line.upBottomPoint(midV);
        HalfHexLine testLeft = new HalfHexLine(leftV,line.p1);
        HalfHexLine testMid = new HalfHexLine(leftV,midV);
        HalfHexLine testRight = new HalfHexLine(rightV,midV);
        newlines.add(testLeft);
        newlines.add(testMid);
        newlines.add(testRight);
        return newlines;
    }

    void renderLines(){
        for(HalfHexLine line : lines) {
            line.display();
        }
    }

    void generateFractal(int depth){
        if (depth==maxDepth){ 
            renderLines();
            return;
            }
        if (lines.size() == 0){
            HalfHexLine line = new HalfHexLine(start,end);
            lines.add(line);
        }
        ArrayList now = new ArrayList<HalfHexLine>();    // Create empty list
        for(HalfHexLine line : lines) {
            ArrayList<HalfHexLine> newlines = generateHalfHex(line);
            now.addAll(newlines);
            //println("generated");
        }
        lines = now;
        generateFractal(depth+1);
  }
}
class HalfHexLine {
    PVector p1;
    PVector p2;

    HalfHexLine(PVector start, PVector end) {
    p1 = start.copy();
    p2 = end.copy();
  } 
  void display(){
    stroke(255);
    line(p1.x,p1.y,p2.x,p2.y);
  }
  PVector startPoint(){
    return p1.copy();
  }
  PVector endPoint(){
    return p2.copy();
  }
  PVector bottomUpPoint(){
    float newAngle = - PI/3;
    PVector v = PVector.sub(p2,p1);
    //println(v,newAngle);
    // one edge of half-hex is equal to half length
    v.div(2);
    v.rotate(newAngle);
    v.add(p1);
    return v;
  }
    PVector upMidPoint(PVector r){
    PVector v = PVector.sub(p2,p1);
    // one edge of half-hex is equal to half length
    v.div(2);

    v.add(r);
    return v;
  }
  PVector upBottomPoint(PVector m){
    float newAngle = PI/3;
    PVector v = PVector.sub(p2,p1);
    // one edge of half-hex is equal to half length
    v.div(2);
    v.rotate(newAngle);
    v.add(m);
    return v;
  }
}

// MAIN
void draw() {
    //println("Hello? 1");
    background(0,0,0);
    l = new HalfHexFractal(6);

}