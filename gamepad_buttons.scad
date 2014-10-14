function beta(button_d, cap_h) = atan((button_d/2)/cap_h);
function gamma(beta) = 2*beta-90;
function r_from_button_d(button_d, cap_h) = ((button_d/2)/cos(gamma(beta(button_d, cap_h))));

module cap(d, h) {
//	echo("beta: ", beta(d, h));
//	echo("gamma: ", gamma(beta(d, h)));
//	echo("cap sphere diameter", 2*r_from_button_d(d,h));
	cphere_d = 2*r_from_button_d(d,h);

	translate([0,0,-cphere_d/2+1]) difference() {
		sphere(d = cphere_d, $fn=200);
		translate([0,0,-h]) cube([cphere_d, cphere_d, cphere_d], center=true);
	}
}

module button(d, h, hole_d, hole_h) {
	difference() {
		translate([0,0,h/2]) union() {
			translate([0,0,h/2]) cap(d, 1);
			cylinder(d = d, h=h, center=true, $fn=200);
			translate([0,0,-(h/2-0.5)]) cylinder(d = d+2, h=1, center=true, $fn=200);
		}
		cylinder(d=hole_d, h=hole_h, $fn=200);
	}
}


for(i=[0:2]) {
	for(j=[0:2]) {
		translate([i*15, j*15, 0]) {
			if (i == 0) button(10, 4, 4, 3);
			if (i == 1) button(10, 4, 4, 3);
			if (i == 2) button(8, 4, 4, 3);
		}
	}
}

//button(10, 4, 4, 2.5);