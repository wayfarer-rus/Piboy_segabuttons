
module buttonHole(offset, button_D, border_width) {
	translate(offset) cylinder(h = 200, d = button_D+1, center = true, $fn=200);
}

module button(switch_H, offset, button_D, border_width) {
	translate(offset+[0,0,(switch_H-1)/2]) cylinder(h = switch_H-1, d = (button_D+2*border_width), center = true, $fn=200);
}

module gamepadMask() {
	gamepadSize = [73,90,100];
	offset = [-20,0,0];
	difference() {
		cube([200,100,100], center=true);
		translate(offset) cube(gamepadSize, center=true);
	}
}

module modifiedPiboy(cross_offset, buttons_offset, plate_XY, ss_offset, ss_size_XY, new_ssm_offset, new_ssm_size_XY) {
	eraser_width = 100;
	button_eraser = plate_XY + [0,0,eraser_width];
	ss_eraser = ss_size_XY + [0,0,eraser_width];
	ss_eraser2 = new_ssm_size_XY + [0,0,eraser_width];;
	top_width = 2;
	
	difference() {
		import("./STL-files/piboy-top.stl", 10);
		translate(cross_offset) cylinder(h=100, d=35, center=true, $fn=200);
		translate(buttons_offset) cube(button_eraser, center=true);
		translate(ss_offset) cube(ss_eraser, center=true);
		translate(new_ssm_offset) cube(ss_eraser2, center=true);
	}
}

module modifiedBezel(offset) {
	translate(offset) {
		difference() {
			translate([0,0,11.1]) rotate([180,0,0]) import("./STL-files/Complete_D-Pad/bezel.stl", 10);
			difference() {
				cylinder(h=40,d=48,center=true, $fn=200);
				cylinder(h=40,d=36,center=true, $fn=200);
			}
		}
	}
}

module newButtonHoles(plate_offset, plate_XY, buttons_offset) {
	top_width = 2;
	big_buttons = [
					[-9.05,30.5,0], //C
					[-15.05,17.5,0], //B
					[-16.05,4.5,0], //A
//				    ];
//	smaller_buttons = [
							[4, 30.45,0], //Z
							[-2, 17.5,0], //Y
							[-3, 4.5,0], //X
                     ];
	big_button_D = 10;
//	smaller_button_D = 8;
	switch_H = 4;
	border_width = 2;

	difference() {
		union() {
			translate(plate_offset + [0,0,top_width/2]) cube(plate_XY + [0,0,top_width], center=true);
			for(i = big_buttons) {
				button(switch_H, i+buttons_offset, big_button_D, border_width);
	//			button(switch_H, smaller_buttons[i]+buttons_offset, smaller_button_D, border_width);
			}
		}
		for(i = big_buttons) {
			buttonHole(i+buttons_offset, big_button_D, border_width);
		//	buttonHole(smaller_buttons[i]+buttons_offset, smaller_button_D, border_width);
		}
	}
}


module newSelectStartMenueButtons(ss_offset, ss_size_XY, new_ssm_offset, new_ssm_size_XY) {
	top_width = 2;
	buttons = [[0,2.5,0], [0,15,0], [0,-10,0]];
	button_d = 8;
	switch_H = 4;
	border_width = 2;

	difference() {
		union() {
			translate(ss_offset + [0,0,top_width/2]) cube(ss_size_XY + [0,0,top_width], center=true);
			translate(new_ssm_offset + [0,0,top_width/2]) cube(new_ssm_size_XY + [0,0,top_width], center=true);
			for(i = [0:1:2]) {
				button(switch_H, buttons[i]+new_ssm_offset, button_d, border_width);
			}
		}
		for(i = [0:1:2]) {
			buttonHole(buttons[i]+new_ssm_offset, button_d, border_width);
		}
	}
}

module gamepad_top() {
	// offset from model's center point
	cross_offset=[-15,-23.5,0];
	buttons_plate_offset=[-15,20,0];
	buttons_plate_size_XY = [35,44,0];
	buttons_offset = [-7,0,0];
	select_start_plate_offset = [-42, 0, 0];
	select_start_size_XY = [20,35,0];
	new_ssm_plate_size_XY = [10,40,0];
	new_ssm_plate_offset = [7,0,0];

	difference() {
		union() {
			modifiedPiboy(cross_offset,buttons_plate_offset,buttons_plate_size_XY, select_start_plate_offset, select_start_size_XY, new_ssm_plate_offset, new_ssm_plate_size_XY);
			modifiedBezel(cross_offset);
			newButtonHoles(buttons_plate_offset,buttons_plate_size_XY, buttons_offset);
			newSelectStartMenueButtons(select_start_plate_offset, select_start_size_XY, new_ssm_plate_offset, new_ssm_plate_size_XY);
		}

		gamepadMask();
	}
}

module buttons_base() {
	buttons_base_points = [[10,40], [12,20], [12,-15], [3,-13], [0,-4], [-30,-2], [-29,20], [-23,40]];
	buttons_centers = [[8,2.5,0],
							[8,15,0],
							[8,-10,0],
							[-16.05,30.5,0],
							[-22.05,17.5,0],
							[-23.05,4.5,0],
							[-3, 30.45,0],
							[-9, 17.5,0],
							[-10, 4.5,0]];
	wire_holes = [[8,21,0],
						[-16.05,36.5,0],
						[-3, 36.4,0],
						[-3, 17.5,0],
						[-4, 4.5,0]];
	wire_pathes = [[2,2.5,0],
							[2,-10,0],
							[-28.05,17.5,0],
							[-29.05,4.5,0]];
	button_base_size = [6,6,3.5];
	button_border_size = [10,10,3.5];
	difference() {
		union() {
			translate([-10,-41,8.5]) {
				linear_extrude(height = 3, convexity = 10, twist = 0) {
					difference() {
						minkowski($fn=200) {
							polygon(buttons_base_points);
							translate([10,41,0]) circle(r=2);
						}
						translate([16.1,77.8,0]) circle(r=3.5, $fn=200);
					}
				}
			}
			for(i = buttons_centers) {
				translate(i + [-5,-5,5]) cube(button_border_size);
			}
		}
		for(i = buttons_centers) {
			translate(i + [-3,-3,5]) cube(button_base_size);
		}
		for(i = wire_holes) {
			translate(i + [-3,-3,5]) cube(button_base_size+[0,0,10]);
		}
		for(i = wire_pathes) {
			translate(i + [-3,-3,5]) cube(button_base_size);
		}
	}
}

module cross_secure_ring_shablone() {
	cross_offset=[-15,-23.5,0];
	cylinder_h = 20;
	difference() {
		translate(cross_offset+[0,0,cylinder_h/2+2]) cylinder(d=45, h=cylinder_h, center=true, $fn=200);
		translate(cross_offset+[0,0,cylinder_h/2+2]) cylinder(d=36, h=cylinder_h, center=true, $fn=200);
	}
}

module cross_secure_ring() {
	cross_offset=[-15,-23.5,2];
	translate(cross_offset+[0,0,6.95])
	rotate([180,0,0]) import("./STL-files/Complete_D-Pad/securingring.stl", 10);
}

//buttons projection
module buttons_projections() {
	union() {
		translate([8,2.5,0]) cylinder(d=1, h=100, center=true, $fn=200);
		translate([8,15,0]) cylinder(d=1, h=100, center=true, $fn=200);
		translate([8,-10,0]) cylinder(d=1, h=100, center=true, $fn=200);
		translate([-16.05,30.5,0]) cylinder(d=1, h=100, center=true, $fn=200);
		translate([-22.05,17.5,0]) cylinder(d=1, h=100, center=true, $fn=200);
		translate([-23.05,4.5,0]) cylinder(d=1, h=100, center=true, $fn=200);
		translate([-3, 30.45,0]) cylinder(d=1, h=100, center=true, $fn=200);
		translate([-9, 17.5,0]) cylinder(d=1, h=100, center=true, $fn=200);
		translate([-10, 4.5,0]) cylinder(d=1, h=100, center=true, $fn=200);
	}
}

module new_secure_ring_final() {
	difference() {
		difference() {
			translate([15,23.5,-2])
			difference() {
				cross_secure_ring();
				gamepad_top();
			}
			translate([0,-30,0]) cube([20,20,20], center=true);
		}
		translate([22,13,0]) cylinder(h=10, d=10, center=true);
	}
}

module gamepad_top_final() {
	gamepad_top();
}

module buttons_base_final() {
	translate([5,20,11.5])
	rotate([180,0,0])
	difference() {
		buttons_base();
		cross_secure_ring_shablone();
	}
}

new_secure_ring_final();
//buttons_base_final();
