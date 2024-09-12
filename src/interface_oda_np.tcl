# Load the pbctools plugin
package require pbctools
set env(VMDOPTIXWRITEALPHA) 1
source /scratch/saeed/MyScripts/vmd_tcl/src/display_procs.tcl
# mol delete all

# Define a procedure to load a molecule
proc load_molecule {style filename} {
    # Delete all molecules
    mol delete all
    # Load the molecule
    set mol [mol load $style $filename]
}

# Define a procedure to delete all representations
proc delete_all_reps {} {
    # Get the number of representations
    set numreps [molinfo top get numreps]

    # Delete all representations
    for {set i 0} {$i < $numreps} {incr i} {
        mol delrep 0 top
    }
}

# Define a procedure to render an image
proc render_image {filename} {
    display resize 4800 4800
    render TachyonLOptiXInternal $filename
}

proc reset_view_and_display {} {
    display resetview
    display projection Orthographic
    axes location Off
    display depthcue on

    light 1 on
    light 2 on
    light 3 off
    light 4 off
}
#

proc visualize_system_face_cut {} {
    # Selecting water molecules
    visualize_residues 0 {resname SOL and z < 138 and z > 130} 2.0
    # Selecting core of the nanoparticle
    visualize_residues 1 {resname COR} 2.0
    ## Selecting aptes of the nanoparticle with the NH3 atoms hidden
    visualize_residues 2 {resname APT and not name N} 2.0
    mol modcolor 2 top "ColorID 2"
    visualize_residues 3 {resname ODN and z>97 and name "C.*" } 2.3
    mol modcolor 3 top "ColorID 2"
    ## Selecting the NH2 atoms of the ODA surfactants
    visualize_residues 4 {resname ODA and name "H.*"} 2.3
    mol modcolor 4 top "ColorID 8"
    visualize_residues 5 {name N} 2.3
    mol modcolor 5 top "ColorID 3"

    reset_view_and_display

    pbc box
    pbc box -width 6 -color black

}



proc visualize_system_np_cut {} {
    # Selecting water molecules
    visualize_residues 0 {resname SOL and z < 138 and z > 130} 1.0
    # Selecting core of the nanoparticle
    visualize_residues 1 {resname COR and z > 130} 2.0
    ## Selecting aptes of the nanoparticle with the NH3 atoms hidden
    visualize_residues 2 {resname APT and not name N and z > 130} 2.0
    mol modcolor 2 top "ColorID 2"
    visualize_residues 3 {resname ODN and z>97 and name "C.*" } 2.3
    mol modcolor 3 top "ColorID 2"
    ## Selecting the NH2 atoms of the ODA surfactants
    visualize_residues 4 {resname ODA and name "H.*"} 2.3
    mol modcolor 4 top "ColorID 8"
    visualize_residues 5 {name N and z > 130} 2.3
    mol modcolor 5 top "ColorID 3"

    reset_view_and_display

    pbc box
    pbc box -width 6 -color black

}

# rotation for the visulization of the interface
proc rotate_interface {} {
       rotate z by -65
    rotate y by 0
    rotate x by -85

    scale by 1.33
    # translate by 0 -0.3 0
}


puts "__________________________"
set structure [lindex $argv 0]
puts $structure
load_molecule gro $structure
puts "__________________________"
delete_all_reps
visualize_system_np_cut
render_image "interface_top.png"
delete_all_reps
visualize_system_face_cut
rotate_interface
render_image "interface.png"


exit