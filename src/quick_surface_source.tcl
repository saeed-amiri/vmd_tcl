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


proc rotate_box {} {
    rotate_view 0 0 -65
    rotate_view -85 0 0
}


proc visualize_system_face_cut {} {
    # Selecting water molecules
    visualize_residues 0 {resname SOL} .5
    mol modstyle 0 0 QuickSurf 1.200000 0.500000 1.000000 1.000000
    mol modcolor 0 0 ColorID 15
    color change rgb 15 0.540000 0.850000 0.999000
    mol modmaterial 0 0 Transparent
    material change opacity Transparent 0.30000
    display rendermode GLSL
    display height 5.00
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
    display depthcue off
}


proc visualize_system_np_cut {} {
    # Selecting water molecules
    visualize_residues 0 {resname SOL and z < 138 and z > 130} .5
    mol modstyle 0 0 QuickSurf 1.200000 0.500000 1.000000 1.000000
    mol modcolor 0 0 ColorID 15
    color change rgb 15 0.540000 0.850000 0.999000
    mol modmaterial 0 0 Transparent
    material change opacity Transparent 0.30000
    display projection Perspective
    display rendermode GLSL
    display height 5.00
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
    display depthcue off

    pbc box
    pbc box -width 6 -color black

}


proc visualize_system_box {} {
    # Selecting water molecules
    visualize_residues 0 {resname SOL and z < 110 and (x+y+z)<320} .5
    mol modstyle 0 0 QuickSurf 1.200000 0.500000 1.000000 1.000000
    mol modcolor 0 0 ColorID 15
    color change rgb 15 0.540000 0.850000 0.999000
    mol modmaterial 0 0 Transparent
    material change opacity Transparent 0.40000
    display rendermode GLSL
    display height 5.00
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
    visualize_residues 9 "resname D10 and z > 90 and (x+y+z)<320" 0.50
    mol modcolor 9 top "ColorID 4"
    mol modstyle 9 top QuickSurf 1.200000 0.500000 1.000000 1.000000
    mol modmaterial 9 top Transparent
    material change opacity Transparent 0.40000

    reset_view_and_display
    display depthcue off
    pbc box
    pbc box -width 6 -color black
    rotate_box
}

proc visualize_edl_structure {} {
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
    mol modmaterial 9 top Transparent
    material change opacity Transparent 0.30000
    mol modstyle 9 top QuickSurf 3.00000 11.800000 1.000000 3.00000
    display rendermode GLSL
    # Reset the view
    reset_view_and_display
    display depthcue off

    # Rotate the view
    rotate_box

    scale by 1.33
    pbc box
    pbc box -width 6 -color black

}
proc rotate_clip {} {
    rotate_view 0 0 65
    rotate_view -85 0 0
}
proc visualize_system_clip {} {
    # Selecting water molecules
    pbc wrap -all -compound fragment -center com -centersel "resname COR"
    visualize_residues 0 {resname SOL and z < 150} .5
    mol selupdate 0 0 1
    mol modstyle 0 0 QuickSurf 1.200000 0.500000 1.000000 1.000000
    mol modcolor 0 0 ColorID 15
    color change rgb 15 0.540000 0.850000 0.999000
    mol modmaterial 0 0 Transparent
    material change opacity Transparent 0.30000
    display rendermode GLSL
    display height 5.00
    # Selecting core of the nanoparticle
    visualize_residues 1 {resname COR} 2.0
    mol smoothrep 0 1 3
    ## Selecting aptes of the nanoparticle with the NH3 atoms hidden
    visualize_residues 2 {resname APT and not name N} 2.0
    mol smoothrep 0 2 3
    mol modcolor 2 top "ColorID 2"
    visualize_residues 3 {resname ODN and z>97 and name "C.*" } 3
    mol smoothrep 0 3 3
    mol modcolor 3 top "ColorID 2"
    visualize_residues 4 {name N} 3.0
    mol smoothrep 0 4 3
    mol modcolor 4 top "ColorID 0"
    ## Selecting the NH2 atoms of the ODA surfactants
    visualize_residues 5 {resname ODA and name "H.*"} 2.3
    mol smoothrep 0 5 3
    mol modcolor 5 top "ColorID 8"
    visualize_residues 6 "name NH2" 4.0
    mol smoothrep 0 6 3
    mol modcolor 6 top "ColorID 3"
    visualize_residues 7 "name CLA and z < 150" 3.0
    mol smoothrep 0 7 3
    mol modcolor 7 top "ColorID 7"
    visualize_residues 8 "name POT and z < 150" 3.0
    mol smoothrep 0 8 3
    mol modcolor 8 top "ColorID 30"
    reset_view_and_display
    display depthcue off
    color Display Background white
}

proc visualize_system_sink {} {
    # Selecting water molecules
    pbc wrap -all -center com -centersel "resname COR APT"
    visualize_residues 0 {resname SOL and z < 150} .5
    mol selupdate 0 0 1
    mol modstyle 0 0 QuickSurf 1.200000 0.500000 1.000000 1.000000
    mol modcolor 0 0 ColorID 15
    color change rgb 15 0.540000 0.850000 0.999000
    mol modmaterial 0 0 Transparent
    material change opacity Transparent 0.30000
    display rendermode GLSL
    display height 5.00
    # Selecting core of the nanoparticle
    visualize_residues 1 {resname COR} 2.0
    mol smoothrep 0 1 3
    
    ## Selecting aptes of the nanoparticle with the NH3 atoms hidden
    visualize_residues 2 {resname APT and not name N} 2.0
    mol smoothrep 0 2 3
    mol modcolor 2 top "ColorID 2"
    visualize_residues 3 {resname ODN and z>97 and name "C.*" } 3
    mol smoothrep 0 3 3
    mol modcolor 3 top "ColorID 2"
    visualize_residues 4 {name N} 3.0
    mol smoothrep 0 4 3
    mol modcolor 4 top "ColorID 0"
    ## Selecting the NH2 atoms of the ODA surfactants
    visualize_residues 5 {resname ODA and name "H.*"} 2.3
    mol smoothrep 0 5 3
    mol modcolor 5 top "ColorID 8"
    visualize_residues 6 "name NH2" 4.0
    mol smoothrep 0 6 3
    mol modcolor 6 top "ColorID 3"
    visualize_residues 7 "name CLA and z < 150" 3.0
    mol smoothrep 0 7 3
    mol modcolor 7 top "ColorID 7"
    color change rgb 7 0.000000 0.666667 0.000000
    visualize_residues 8 "name POT and z < 150" 3.0
    mol smoothrep 0 8 3
    mol modcolor 8 top "ColorID 30"
    visualize_residues 9 "resname D10 and z > 90" 0.50
    mol modcolor 9 top "ColorID 4"
    mol modstyle 9 top QuickSurf 1.200000 0.500000 1.000000 1.000000
    mol modmaterial 9 top Transparent
    reset_view_and_display
    display depthcue off
    color Display Background white
    rotate_view -90 0 0
    remove_pbc
}

proc np_alone {} {
    # Selecting core of the nanoparticle
    visualize_residues 0 {resname COR} 2.0
    mol smoothrep 0 0 3
    ## Selecting aptes of the nanoparticle with the NH3 atoms hidden
    visualize_residues 1 {resname APT and not name N} 2.0
    mol smoothrep 0 1 3
    mol modcolor 1 top "ColorID 2"
}
proc set_transparent {} {
material change ambient      Transparent 0.000000
material change diffuse      Transparent 0.850000
material change specular     Transparent 0.500000
material change shininess    Transparent 0.530000
material change mirror       Transparent 0.000000
material change opacity      Transparent 0.200000
material change outline      Transparent 2.000000
material change outlinewidth Transparent 0.340000
}
