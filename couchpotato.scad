include <Chamfers-for-OpenSCAD/Chamfer.scad>;

$fn = 50;

holderX = 120;
holderThickness = 10;
holderZ = 20;

/* Aquaris X with slim case */
/* phoneHolderX = 80;
phoneY = 76;
phoneZ = 9;
phoneHolderWall = 2;

patternOn = true;
cutoutCount = 4;
cutoutHeight = 50;
cutoutRadius = 5;
cutoutDistance = 18;
cutoutXshift = 7;
slideZshift = 0; */

/* Samsung Galaxy Tab2 */
/* phoneHolderX = 140;
phoneY = 170;
phoneZ = 7;
phoneHolderWall = 2;

patternOn = true;
cutoutCount = 5;
cutoutHeight = 140;
cutoutRadius = 6;
cutoutDistance = 25;
cutoutXshift = 12;
slideZshift = 0; */

/* PocketBook InkPad Color or InkPad 3 with OrigamiCase */
phoneHolderX = 100;
phoneY = 142; //with case
phoneZ = 13;
phoneHolderWall = 3;

patternOn = true;
cutoutCount = 4;
cutoutHeight = 110;
cutoutRadius = 6;
cutoutDistance = 22;
cutoutXshift = 8;
slideZshift = 1;


extensionLen = 150;
extensionY = 50;

lockingExtrusionHeight = 4;

borderWall = 2;
backWall = 2;

railExtra = 1;
railRad = 2;

railExtr = 100; //fixed extrusion of rails in clamp

extra = 0.01;



module pattern(rad=10,thickness=2, dist=50, heigth=40, cnt=5)
{
  for(obj=[0:cnt-1])
    translate([dist*obj,0,-extra])
    hull()
    {
      cylinder(r=rad,h=thickness);
      translate([0,heigth-rad*2,]) cylinder(r=rad,h=thickness);
    }
}


module rail(lenY=50,innerRail=false)
{
  if(innerRail == true)
  {
    cube([holderThickness/2+railExtra,lenY,3]);
    translate([railRad,0,3]) rotate([-90,0,0])
    cylinder(r=railRad,h=lenY);
  }else{
    scale([1.05,1,1.05])
    union()
    {
      cube([holderThickness/2+railExtra,lenY,3]);
      translate([railRad,0,3]) rotate([-90,0,0])
      cylinder(r=railRad,h=lenY);
    }
  }
}

module U()
{
  hull()
  {
    cube([holderThickness,100,holderZ]);
    translate([0,140,holderZ/2]) rotate([0,90,0]) cylinder(r=holderZ/2,h=holderThickness);
  }
}
/* X(); */

module A()
{
  difference()
  {
    union()
    {
      cube([holderX,holderThickness,holderZ]);
        U();
      translate([holderX-holderThickness,0,0])
        U();
    }
    moveRailX = holderX-holderThickness/2-railExtra;
    moveRailScale = 0;//(holderThickness/2+railExtra)*0.05;
    translate([moveRailX-moveRailScale,0,(holderZ)/2])
      resize([0,100,0]) scale([1.05,1,1.05]) rail(phoneY+phoneHolderWall*2,innerRail=true);
  }
}


module CouchPotatoClamp()
{
  A();
  translate([0,0,holderZ*3])
    A();
  translate([20,0,holderZ]) cube([20,holderThickness,holderZ*2]);
  translate([holderX-40,0,holderZ]) cube([20,holderThickness,holderZ*2]);

  translate([0,30,13])
  union()
  {
    difference() {
      rotate([-50,0,0])
      translate([0,0,holderZ/2])
      cube([holderThickness,10,holderZ*4]);
      translate([0,0,-13]) cube([holderThickness,50,holderZ]);
      translate([0,40,-13+holderZ*3]) cube([holderThickness,50,holderZ]);
    }
  }
  translate([holderX-holderThickness,30,13])
  union()
  {
    difference() {
      rotate([-50,0,0])
      translate([0,0,holderZ/2])
      cube([holderThickness,10,holderZ*4]);
      translate([0,0,-13]) cube([holderThickness,50,holderZ]);
      translate([0,40,-13+holderZ*3]) cube([holderThickness,50,holderZ]);
    }
  }
}
/* A(); */

module deviceHolder()
{
  difference() {
    cube([phoneHolderX,phoneY+phoneHolderWall*2,phoneZ+backWall+lockingExtrusionHeight]);

    hull()
    {
    translate([borderWall,phoneHolderWall,backWall])
      cube([phoneHolderX-borderWall+extra,phoneY,phoneZ]);
    translate([borderWall,phoneHolderWall+lockingExtrusionHeight,backWall])
      cube([phoneHolderX-borderWall+extra,phoneY-lockingExtrusionHeight*2,phoneZ+lockingExtrusionHeight+extra]);
    }


    if(patternOn == true)
    {
      translate([(cutoutRadius+backWall)+cutoutXshift,cutoutRadius+(phoneY+phoneHolderWall*2)/2-(cutoutHeight/2),0])
        pattern(rad=cutoutRadius,thickness=backWall+extra*2, dist=cutoutDistance, heigth=cutoutHeight, cnt=cutoutCount);
    }
  }
  translate([-holderThickness/2-railExtra,0,0]) rail( phoneY+phoneHolderWall*2);
}

module extension(bottom=true)
{
  union()
  {
    rail();
    difference()
    {
      union()
      {
        translate([holderThickness/2+railExtra,0,0]) cube([extensionLen,extensionY,11]);
      }
      translate([20,12.5,0]) pattern(rad=8,thickness=11, dist=28, heigth=40, cnt=5);
      if(bottom == true)
      {
        translate([extensionLen,-2,3]) rail(innerRail=true);
      }else{
        translate([extensionLen,0,3])  rail(innerRail=true);
      }
    }
  }
}

handHolderX = 20;
handHolderY = 40;
handHolderRadius = 4;
handHolderZoffset = 1;  //endstop for rail (offset from the bottom)
module couchPotatoHandHandle()
{
  difference()
  {
    translate([handHolderRadius,handHolderRadius,0])
    minkowski()
    {
      tempHeight = phoneY+phoneHolderWall*2+1;
      chamferCylinder(tempHeight,r=handHolderRadius);
      cube([handHolderX-handHolderRadius*2,handHolderY-handHolderRadius*2,0.000000000001]);
    }
    tempHeight = phoneY+phoneHolderWall*2;
    translate([holderThickness/2+railExtra,030,tempHeight+1]) rotate([90,180,0])
      scale([1.05,1,1.05]) rail(tempHeight,innerRail=true);
  }
}
/* couchPotatoHandHandle(); */


/* extension(false); */

deviceHolder();

/* translate([-holderX,10,0]) CouchPotatoClamp(); */
