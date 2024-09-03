# Load the pbctools plugin
package require pbctools
set env(VMDOPTIXWRITEALPHA) 1

source /scratch/saeed/MyScripts/vmd_tcl/src/display_procs.tcl

mol delete all

proc visualize_system_face_cut {} {
    # Selecting water molecules
    visualize_residues 0 "resname SOL" 2.0
    # Selecting core of the nanoparticle
    visualize_residues 1 "resname COR" 3.0
    # Selecting aptes of the nanoparticle with the NH3 atoms hidden
    visualize_residues 2 "resname APT and not name N" 2.0
    mol modcolor 2 top "ColorID 2"
    # Selecting the NH3 atoms of the aptes
    visualize_residues 3 {name N} 3.0
    mol modcolor 3 top "ColorID 0"
    # Selecting the CL ions
    visualize_residues 4 "resname CLA" 3.0
    mol modcolor 4 top "ColorID 7"
    # Selecting the NA ions
    visualize_residues 5 "resname POT" 4.0
    mol modcolor 5 top "ColorID 30"
    # Selecting the ODA surfactants with the NH2 atoms hidden
    visualize_residues 6 {name "HA.*"} 2.0
    mol modcolor 6 top "ColorID 8"
    visualize_residues 7 "resname ODN and z>90 and not name NH2" 2.0
    mol modcolor 7 top "ColorID 2"
    # Selecting the NH2 atoms of the ODA surfactants
    visualize_residues 8 "name NH2 and z > 90" 4.0
    mol modcolor 8 top "ColorID 3"
    # Selecting oil molecules
    visualize_residues 9 "resname D10" 2.0
    mol modcolor 9 top "ColorID 4"
    # visualize_residues 10 "resname APT and 'HA.*'" 2.0
    # mol modcolor 10 top "ColorID 2"

    # Reset the view
    reset_view_and_display

    rotate z by -65
    rotate y by 0
    rotate x by -85

    scale by 1.33
    # translate by -0.3 -0.3 0

    pbc box
    pbc box -width 6 -color black

    # Call the procedure
}

proc visualize_np_core {} {
    visualize_residues 0 "resname COR" 2.0

    reset_view_and_display    

    rotate z by -65
    rotate y by 0
    rotate x by -85

    scale by 1.33
    # scale by 1.6
    translate by 0 0 0

    pbc box
    pbc box -width 6 -color black
}

proc visualize_np {} {
    delete_all_reps
    visualize_residues 0 "resname COR" 1.5
    # visualize_residues 1 "resname APT and not name N" 1.5
    visualize_residues 1 {resname APT and name "C.*" and not name N} 1.5
    mol modcolor 1 top "ColorID 2"
    visualize_residues 2 {resname APT and name "H.*" and not name N} 1.5
    mol modcolor 2 top "ColorID 8"
    # mol modcolor 1 top "ColorID 2"
    # Selecting the NH3 atoms of the aptes
    visualize_residues 3 "name N" 2.0
    mol modcolor 3 top "ColorID 0"

    reset_view_and_display

    rotate z by -65
    rotate y by 0
    rotate x by -85

    scale by 1.33
    translate by 0 0 0

    pbc box
    pbc box -width 6 -color black
}


proc visualize_decane {} {
    delete_all_reps
    visualize_residues 0 {resname D10 and name "C.*"} 2.1
    mol modcolor 0 top "ColorID 2"
    visualize_residues 1 {resname D10 and name "H.*"} 2.1
    mol modcolor 1 top "ColorID 8"
    reset_view_and_display
    rotate z by -65
    rotate y by 0
    rotate x by -85

    scale by 1.33
}

proc visualize_water {} {
    delete_all_reps
    visualize_residues 0 "resname SOL" 2.0
    reset_view_and_display
    rotate z by -65
    rotate y by 0
    rotate x by -85

    scale by 1.33
}

proc visualize_cl {} {
    delete_all_reps
    visualize_residues 0 "resname CLA" 2.0
    reset_view_and_display
    mol modcolor 0 top "ColorID 7"
    rotate z by -65
    rotate y by 0
    rotate x by -85

    scale by 1.33
}

proc visualize_na {} {
    delete_all_reps
    visualize_residues 0 "resname POT" 2.0
    reset_view_and_display
    mol modcolor 0 top "ColorID 30"
}

proc visualize_apt {} {
    delete_all_reps
    visualize_residues 0 {resname APT and not name N and name "C.*"} 2.3
    mol modcolor 0 top "ColorID 2"
    visualize_residues 1 {resname APT and not resname COR and not name N and name "H.*"} 2.3
    mol modcolor 1 top "ColorID 8"
    visualize_residues 2 "name N" 2.3
    mol modcolor 2 top "ColorID 0"
    visualize_residues 3 {resname APT and not resname COR and name Si "OM.*"} 2.3
    reset_view_and_display
    rotate z by -65
    rotate y by 0
    rotate x by -85

    scale by 1.33
}

proc visualize_oda {} {
    delete_all_reps
    visualize_residues 0 {resname ODA and name "C.*"} 2.3
    mol modcolor 0 top "ColorID 2"
    visualize_residues 1 {resname ODA and name "H.*"} 2.3
    mol modcolor 1 top "ColorID 8"
    visualize_residues 2 "name N" 2.3
    mol modcolor 2 top "ColorID 3"
    reset_view_and_display
    rotate x by 20
}
proc visualize_scoop {} {
    delete_all_reps
    visualize_residues 0 "resname COR" 1.5
    visualize_residues 1 {resname APT and name "C.*" and not name N} 1.5
    mol modcolor 1 top "ColorID 2"
    visualize_residues 2 {resname APT and name "H.*" and not name N} 1.5
    mol modcolor 2 top "ColorID 8"
    # Selecting the NH3 atoms of the aptes
    visualize_residues 3 "name N" 2.0
    mol modcolor 3 top "ColorID 0"
    visualize_residues 4 "resname SOL" 2.0
    visualize_residues 5 "resname CLA" 2.0
    mol modcolor 5 top "ColorID 7"
    rotate z by -65
    rotate y by 0
    rotate x by -85

    translate by 0 0 0

}
proc minmax_d10 {molid} {
  set sel [atomselect $molid "resname D10"]
  set coords [$sel get {x y z}]
  set coord [lvarpop coords]
  lassign $coord minx miny minz
  lassign $coord maxx maxy maxz
  foreach coord $coords {
    lassign $coord x y z
    if {$z < $minz} {set minz $z} else {if {$z > $maxz} {set maxz $z}}
  }
  $sel delete
  return [list $minz $maxz]
}
proc box_molecule {molid minz maxz color} {
    # get the min and max values for each of the directions
    set pbc [pbc get -molid $molid]
    puts "__________________________"
    puts "PBC: $pbc"

    set a [lindex $pbc 0 0]
    set b [lindex $pbc 0 1]
    set c [lindex $pbc 0 2]

    puts "__________________________"
    puts "a: $a, b: $b, c: $c"
    puts "__________________________"
    # set the min and max values for each direction based on the PBC box
    set minx 0
    set maxx $a
    set miny 0
    set maxy $b

    puts "__________________________"
    puts "minx: $minx, maxx: $maxx, miny: $miny, maxy: $maxy, minz: $minz, maxz: $maxz"
    puts "__________________________"

    # draw the filled polygons
    graphics top color $color
    graphics top material Transparent

    # Bottom face
    graphics top triangle "$minx $miny $minz" "$maxx $miny $minz" "$maxx $maxy $minz"
    graphics top triangle "$minx $miny $minz" "$minx $maxy $minz" "$maxx $maxy $minz"

    # Top face
    graphics top triangle "$minx $miny $maxz" "$maxx $miny $maxz" "$maxx $maxy $maxz"
    graphics top triangle "$minx $miny $maxz" "$minx $maxy $maxz" "$maxx $maxy $maxz"

    # Front face
    graphics top triangle "$minx $miny $minz" "$maxx $miny $minz" "$maxx $miny $maxz"
    graphics top triangle "$minx $miny $minz" "$minx $miny $maxz" "$maxx $miny $maxz"

    # Back face
    graphics top triangle "$minx $maxy $minz" "$maxx $maxy $minz" "$maxx $maxy $maxz"
    graphics top triangle "$minx $maxy $minz" "$minx $maxy $maxz" "$maxx $maxy $maxz"

    # Left face
    graphics top triangle "$minx $miny $minz" "$minx $maxy $minz" "$minx $maxy $maxz"
    graphics top triangle "$minx $miny $minz" "$minx $miny $maxz" "$minx $maxy $maxz"

    # Right face
    graphics top triangle "$maxx $miny $minz" "$maxx $maxy $minz" "$maxx $maxy $maxz"
    graphics top triangle "$maxx $miny $minz" "$maxx $miny $maxz" "$maxx $maxy $maxz"
}
proc draw_boxes {molid minz intervals color} {
    set index 0

    foreach interval $intervals {
        set start_z [expr $minz + $interval]
        set end_z [expr $start_z + 3]
        set color $color
        box_molecule $molid $start_z $end_z $color
        incr index
    }
}

puts "__________________________"
set structure [lindex $argv 0]
puts "Structure: $structure"

proc load_molecule {type filename} {
    if {[file exists $filename]} {
        mol new $filename type $type
    } else {
        puts "Error: File $filename does not exist."
        exit 1
    }
}
puts "__________________________"

# Replace "your_file.gro" with your actual filename
load_molecule gro $structure
delete_all_reps
visualize_system_face_cut
render_image "structure_15da.png"


delete_all_reps
mol delete all

load_molecule gro $structure
delete_all_reps
visualize_np_core
render_image "structure_core.png"

mol delete all

load_molecule gro $structure
delete_all_reps
visualize_np
render_image "structure_np.png"

mol delete all
load_molecule gro $structure
delete_all_reps
visualize_apt
render_image "structure_apt.png"

mol delete all
load_molecule gro $structure
delete_all_reps
visualize_cl
render_image "structure_cl.png"

mol delete all
load_molecule gro $structure
delete_all_reps
visualize_na
render_image "structure_na.png"

mol delete all
load_molecule gro $structure
delete_all_reps
visualize_decane
render_image "structure_decane.png"

mol delete all
load_molecule gro $structure
delete_all_reps
visualize_water
render_image "structure_water.png"

mol delete all
load_molecule gro $structure
visualize_scoop
scale by 3.33
render_image "structure_scoop.png"


set pbc [pbc get -molid top]
set a [lindex $pbc 0 0]
set b [lindex $pbc 0 1]
set c [lindex $pbc 0 2]
set com_x [expr {$a / 2.0}]
set com_y [expr {$b / 2.0}]
set com_z [expr {$c / 2.0}]
puts "COM: $com_x $com_y $com_z"

graphics top sphere [list $com_x $com_y $com_z] radius 36 resolution 100
graphics top material Transparent
translate by 0 1 0
render_image "structure_scoop_sphere.png"
scale by 0.3003003
translate by 0 -1 0
pbc box
pbc box -width 6 -color black

set minmax_d10_z [minmax_d10 top]
set minz [lindex $minmax_d10_z 0]
set maxz [lindex $minmax_d10_z 1]
puts "Min and Max Z coordinates of D10 residues: $minz, $maxz"
pbc box -width 6 -color black
box_molecule top 0 $minz red3
render_image "structure_scoop_box.png"
pbc box -width 6 -color black
box_molecule top $minz $maxz yellow
render_image "structure_scoop_double_box.png"

graphics top delete all
graphics top sphere [list $com_x $com_y $com_z] radius 36 resolution 100
graphics top material Transparent

draw_boxes top $minz  [list -3 -8 -13 -18 -23 -28 -33 -38 -43 -48 -53] red3
draw_boxes top $minz  [list 2 7 12 15]  yellow


# graphics top material plastic
render_image "structure_scoop_layers.png"


exit