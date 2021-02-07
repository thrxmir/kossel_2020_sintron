//FolgerTech Kossel Mini Endstop Bracket Modification
//7/8/2016      By: David Bunch
//
//From: http://www.thingiverse.com/thing:1540280
//Made it so I could change Dia. of Holes if Needed
//This is 11mm shorter than other design which should mean 11mm more height on Delta
//Changed inside cut to miss solder joints on limit switch board
//I did not have an M3x8mm bolt, so I used a M3x10mm bolt with a plastic spacer
//The M3x10mm bolt was going to far thru the T-Nut to work without the spacer
//M3x8mm bolt for T-Nut I think would work better
//I also added a little bump to fit in the extrusion to keep it in place with only 1 T-Nut
//
//I used 2x M2.5x10mm bolts & locknuts to hold switch on plastic
//1x M3x10mm bolt with plastic spacer with T-Nut (M3x8mm should work without spacer)
Ht = 4;             //Height of Base Profile
M2_5 = 3.0;         //M2.5 Bolt Diamter
M3 = 3.6;           //M3 Bolt Diameter
M2_5_Res = 14;      //Resolution of M2.5 Bolt Hole
M3_Res = 18;        //Resolution of M3 Bolt Hole
M3Nut = 6.9;        //OD to show M3, I am using M2.5, but this shows M3 should also work
module Tnut()
{
    color("silver",.5)
    translate([7,20.75,0])
    translate([-2.5,3,0-1.98])
    rotate([90,0,0])
    linear_extrude(height = 6, center = false, convexity = 10)polygon(points = 
    [[-1.07,-1.79],[6.11,-1.79],[8.01,0],[5,0],[5,1.98],
    [0,1.98],[0,0],[-2.9,0]]);
}
module Outline()
{
    union()
    {
        linear_extrude(height = Ht, center = false, convexity = 10)polygon(points = 
        [[0,22],[0,2],[0.1,1.38],[0.38,0.82],[0.82,0.38],
        [1.38,0.1],[2,0],[29,0],[29.62,0.1],[30.18,0.38],
        [30.62,0.82],[30.9,1.38],[31,2],[31,9.88],[30.95,10.58],
        [30.81,11.26],[30.57,11.92],[30.24,12.53],[29.83,13.1],[22.18,22.21],
        [21.67,22.74],[21.1,23.18],[20.46,23.53],[19.78,23.79],[19.08,23.95],
        [18.35,24],[2,24],[1.38,23.9],[0.82,23.62],[0.38,23.18],
        [0.1,22.62],[0,22]]);
        translate([4.5,6.1,-3])
        cube([5,11.4,3.1]);
    }
}
module Cut()
{
    translate([0,0,-1])
    linear_extrude(height = Ht+2, center = false, convexity = 10)polygon(points = 
    [[10.1,14.88],[10.14,15.49],[10.25,16.09],[10.43,16.67],[10.69,17.23],
    [11,17.75],[11.1,17.88],[12.37,20.02],[12.82,20.54],[13.41,20.88],
    [14.09,21],[18.46,21],[18.99,20.9],[19.48,20.65],[19.88,20.29],
    [27.85,10.79],[28.22,10.13],[28.32,9.38],[28.13,8.66],[27.69,8.05],
    [27.06,7.64],[26.32,7.5],[12.1,7.5],[11.48,7.6],[10.92,7.88],
    [10.48,8.32],[10.2,8.88],[10.1,9.5]]);
}
module Holes()
{
//Bottom Holes
    translate([7,3,-1])
    cylinder(d=M2_5,h=Ht+2,$fn=M2_5_Res);   //Limit Switch Hole at extrusion
    translate([26,3,-1])
    cylinder(d=M2_5,h=Ht+2,$fn=M2_5_Res);   //Limit Switch Hole at far end

    translate([7,20.75,-3.5])
    cylinder(d=M3,h=Ht*2,$fn=M2_5_Res);     //T-Nut M3 Hole

    translate([7,3,-2])
    %cylinder(d=M3Nut,h=2,$fn=6);       //show M3 nut for reference, I used M2.5
    %Tnut();                            //Show M3 T-Nut for reference
}
module DrawBracket()
{
    translate([0,0,4])
    rotate([180,0,0])               //Print so bump is on the top
    difference()
    {
        Outline();                  //Main profile of part
        Cut();                      //Main Cut
        Holes();                    //Drill the 3 holes
    }
}
DrawBracket();                      //1st Bracket
translate([37,0,0])
DrawBracket();                      //2nd Bracket
translate([0,30,0])
DrawBracket();                      //3rd Bracket