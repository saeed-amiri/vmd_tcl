# Load the pbctools plugin
package require pbctools
set env(VMDOPTIXWRITEALPHA) 1

source /scratch/saeed/MyScripts/vmd_tcl/src/display_procs.tcl

mol delete all

proc visualize_system_face_cut {} {
    # Selecting water molecules
    visualize_residues 0 "resname SOL and z < 140 and (x+y+z)<320" 2.0
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
    visualize_residues 9 "resname D10 and z > 90 and (x+y+z)<320" 2.0
    mol modcolor 9 top "ColorID 4"
    # visualize_residues 10 "resname APT and 'HA.*'" 2.0
    # mol modcolor 10 top "ColorID 2"

    # Reset the view
    reset_view_and_display

    rotate z by -65
    rotate y by 0
    rotate x by -85

    scale by 1.33
    translate by -0.3 -0.3 0

    pbc box
    pbc box -width 6 -color black

    # Call the procedure
}

proc visualize_np_core {} {
    visualize_residues 0 "resname COR" 2.0

    reset_view_and_display    

    scale by 1.6
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

    scale by 1.6
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
    rotate z by 70
    rotate y by 30
    rotate x by 15
}

proc visualize_water {} {
    delete_all_reps
    visualize_residues 0 "resname SOL" 2.0
    reset_view_and_display
}

proc visualize_cl {} {
    delete_all_reps
    visualize_residues 0 "resname CLA" 2.0
    reset_view_and_display
     mol modcolor 0 top "ColorID 7"
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
    visualize_residues 1 {resname APT and not name N and name "H.*"} 2.3
    mol modcolor 1 top "ColorID 8"
    visualize_residues 2 "name N" 2.3
    mol modcolor 2 top "ColorID 0"
    visualize_residues 3 {resname APT and  name Si "OM.*"} 2.3
    reset_view_and_display
    rotate z by 0
    rotate y by 0
    rotate x by 20
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

set structure [lindex $argv 0]
puts "Structure: $structure"

proc load_molecule {type filename} {
    if {[file exists $filename]} {
        mol new $filename type $type
    } else {
        puts "Error: File $filename does not exist."
    }
}

# Replace "your_file.gro" with your actual filename
load_molecule gro $structure
delete_all_reps
visualize_system_face_cut
render_image "structure_100Oda.png"

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

load_molecule pdb "D10.pdb"
delete_all_reps
visualize_decane
render_image "decane.png"

mol delete all

load_molecule pdb "water.pdb"
delete_all_reps
visualize_water
render_image "water.png"

mol delete all

load_molecule pdb "aptes.pdb"
delete_all_reps
visualize_apt
render_image "aptes.png"

mol delete all

load_molecule pdb "CLA.pdb"
delete_all_reps
visualize_cl
render_image "cl.png"

mol delete all

load_molecule pdb "POT.pdb"
delete_all_reps
visualize_na
render_image "na.png"

mol delete all

load_molecule pdb "ODAp.pdb"
delete_all_reps
visualize_oda
render_image "oda.png"

exit