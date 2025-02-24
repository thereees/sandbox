import three;
import solids;
unitsize(1cm);
size(200);
triple xx = (1,0,0);
triple yy = (0,1,0);
triple zz = (0,0,1);
triple zero = (0,0,0);
transform3 tcurrent = shift(0,0,0);
triple currentjoint = zero;
currentjoint = tcurrent*zero;
xx = tcurrent*(X*0.1);
yy = tcurrent*(Y*0.1);
zz = tcurrent*(Z*0.1);
draw(currentjoint--xx,red);
draw(currentjoint--zz,blue);
draw(tcurrent*scale(0.1,0.1,0.5)*shift(-0.5,-0.5,0)*unitbox, dashed+blue);
triple j1 = currentjoint;
transform3 j1rz = rotate(0,(0,0,1));
transform3 j1tz = shift(0,0,0.5);
transform3 j1tx = shift(0,0,0);
transform3 j1rx = rotate(0,(1,0,0));
tcurrent = tcurrent*j1rz*j1tz*j1tx*j1rx;
currentjoint = tcurrent*zero;
xx = tcurrent*(X*0.1);
yy = tcurrent*(Y*0.1);
zz = tcurrent*(Z*0.1);
draw(currentjoint--xx,red);
draw(currentjoint--zz,blue);
draw(circle(currentjoint, 0.1, (zz.x-currentjoint.x,zz.y-currentjoint.y,zz.z-currentjoint.z)),dotted+0.5bp+blue);
triple j2 = currentjoint;
transform3 j2rz = rotate(45,(0,0,1));
transform3 j2tz = shift(0,0,0);
transform3 j2tx = shift(0.7,0,0);
transform3 j2rx = rotate(0,(1,0,0));
tcurrent = tcurrent*j2rz*j2tz*j2tx*j2rx;
currentjoint = tcurrent*zero;
xx = tcurrent*(X*0.1);
yy = tcurrent*(Y*0.1);
zz = tcurrent*(Z*0.1);
draw(currentjoint--xx,red);
draw(currentjoint--zz,blue);
draw(circle(currentjoint, 0.1, (zz.x-currentjoint.x,zz.y-currentjoint.y,zz.z-currentjoint.z)),dotted+0.5bp+blue);
triple j3 = currentjoint;
transform3 j3rz = rotate(45,(0,0,1));
transform3 j3tz = shift(0,0,0);
transform3 j3tx = shift(0.7,0,0);
transform3 j3rx = rotate(0,(1,0,0));
tcurrent = tcurrent*j3rz*j3tz*j3tx*j3rx;
currentjoint = tcurrent*zero;
xx = tcurrent*(X*0.1);
yy = tcurrent*(Y*0.1);
zz = tcurrent*(Z*0.1);
draw(currentjoint--xx,red);
draw(currentjoint--zz,blue);
draw(tcurrent*scale(0.1,0.1,-0.2)*shift(-0.5,-0.5,0)*unitbox, dashed+blue);
triple j4 = currentjoint;
transform3 j4rz = rotate(0,(0,0,1));
transform3 j4tz = shift(0,0,-0.2);
transform3 j4tx = shift(0,0,0);
transform3 j4rx = rotate(0,(1,0,0));
tcurrent = tcurrent*j4rz*j4tz*j4tx*j4rx;
currentjoint = tcurrent*zero;
xx = tcurrent*(X*0.1);
yy = tcurrent*(Y*0.1);
zz = tcurrent*(Z*0.1);
draw(currentjoint--xx,red);
draw(currentjoint--zz,blue);
draw(circle(currentjoint, 0.1, (zz.x-currentjoint.x,zz.y-currentjoint.y,zz.z-currentjoint.z)),dotted+0.5bp+blue);
triple j5 = currentjoint;
transform3 j5rz = rotate(45,(0,0,1));
transform3 j5tz = shift(0,0,0);
transform3 j5tx = shift(0,0,0);
transform3 j5rx = rotate(0,(1,0,0));
tcurrent = tcurrent*j5rz*j5tz*j5tx*j5rx;
currentjoint = tcurrent*zero;
xx = tcurrent*(X*0.1);
zz = tcurrent*(Z*0.1);
triple j6 = tcurrent*zero;
draw(currentjoint--xx,red);
draw(currentjoint--zz,blue);
draw((0,0,0)--j1--j2--j3--j4--j5--j6);
limits(O,X+Y+Z);
xaxis3(Label("$x$",1),Arrow3);
yaxis3(Label("$y$",1),Arrow3);
zaxis3(Label("$z$",1),Arrow3);
