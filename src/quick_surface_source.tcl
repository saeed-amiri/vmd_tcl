# Visulaisierung von Wasserflächen

# Load the pbctools plugin
package require pbctools
set env(VMDOPTIXWRITEALPHA) 1
set env(VMDGLSLVERBOSE) 0
source /scratch/saeed/MyScripts/vmd_tcl/src/display_procs.tcl


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


proc visualize_system_face_cut {} {
    # Selecting water molecules
    visualize_residues 0 {resname SOL} .5
    mol modstyle 0 0 QuickSurf 1.200000 0.500000 1.000000 1.000000
    mol modcolor 0 0 ColorID 15
    color change rgb 15 iceblue 0.540000 0.850000 0.999000
    mol modmaterial 0 0 Transparent
    material change opacity Transparent 0.10000
    display rendermode GLSL
    display depthcue off
    display projection Perspective
    # Selecting core of the nanoparticle
    visualize_residues 1 {resname COR} 2.0
    ## Selecting aptes of the nanoparticle with the NH3 atoms hidden
    visualize_residues 2 {resname APT and not name N} 2.0
    mol modcolor 2 top "ColorID 2"
    visualize_residues 3 {resname ODN and z>97 and name "C.*" } 3
    mol modcolor 3 top "ColorID 2"
    visualize_residues 4 {name N} 3.0
    mol modcolor 4 top "ColorID 0"
    ## Selecting the NH2 atoms of the ODA surfactants
    visualize_residues 5 {resname ODA and name "H.*"} 2.3
    mol modcolor 5 top "ColorID 8"
    visualize_residues 6 "name NH2" 4.0
    mol modcolor 6 top "ColorID 3"
    visualize_residues 7 "name CLA" 3.0
    mol modcolor 7 top "ColorID 7"
    visualize_residues 8 "name POT" 3.0
    mol modcolor 8 top "ColorID 30"
    reset_view_and_display
}


proc visualize_system_np_cut {} {
    # Selecting water molecules
    visualize_residues 0 {resname SOL and z < 138 and z > 130} 1.0
    mol modstyle 0 0 QuickSurf 1.200000 0.500000 1.000000 1.000000
    mol modcolor 0 0 ColorID 15
    color change rgb 15 iceblue 0.540000 0.850000 0.999000
    mol modmaterial 0 0 Transparent
    display rendermode GLSL
    display depthcue off
    display projection Perspective
    material change opacity RTChrome 0.05
    # Selecting core of the nanoparticle
    visualize_residues 1 {resname COR and z > 130} 2.0
    ## Selecting aptes of the nanoparticle with the NH3 atoms hidden
    visualize_residues 2 {resname APT and not name N and z > 130} 2.0
    mol modcolor 2 top "ColorID 2"
    visualize_residues 3 {resname ODN and z>97 and name "C.*" } 3
    mol modcolor 3 top "ColorID 2"
    visualize_residues 4 {name N and z > 130} 3.0
    mol modcolor 4 top "ColorID 0"
    ## Selecting the NH2 atoms of the ODA surfactants
    visualize_residues 5 {resname ODA and name "H.*"} 2.3
    mol modcolor 5 top "ColorID 8"
    visualize_residues 6 "name NH2" 4.0
    mol modcolor 6 top "ColorID 3"
    reset_view_and_display

    pbc box
    pbc box -width 6 -color black

}


proc rotate_box {} {
    rotate_view 0 0 -65
    rotate_view -85 0 0
}
