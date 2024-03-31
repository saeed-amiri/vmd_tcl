# Load the pbctools plugin
package require pbctools
set env(VMDOPTIXWRITEALPHA) 1

mol delete all

# Define a procedure to load a molecule
proc load_molecule {filename} {
    # Delete all molecules
    mol delete all
    # Load the molecule
    set mol [mol load gro $filename]
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

# Define a procedure with parameters
# Define a procedure with parameters
proc visualize_residues {repIndex selection radius} {
    # Add a new representation with the specified selection
    mol addrep top
    mol modselect $repIndex top $selection
    mol modstyle $repIndex top "CPK $radius 0.0 30.0 12.0"
    mol modmaterial $repIndex top Glassy
}


proc visualize_system_face_cut {} {
    # Selecting water molecules
    visualize_residues 0 "resname SOL and z < 140 and (x+y+z)<320" 2.0
    # Selecting core of the nanoparticle
    visualize_residues 1 "resname COR" 3.0
    # Selecting aptes of the nanoparticle with the NH3 atoms hidden
    visualize_residues 2 "resname APT and not name N" 2.0
    mol modcolor 2 top "ColorID 2"
    # Selecting the NH3 atoms of the aptes
    visualize_residues 3 "name N" 3.0
    mol modcolor 3 top "ColorID 0"
    # Selecting the CL ions
    visualize_residues 4 "resname CLA" 3.0
    mol modcolor 4 top "ColorID 7"
    # Selecting the NA ions
    visualize_residues 5 "resname POT" 4.0
    mol modcolor 5 top "ColorID 30"
    # Selecting the ODA surfactants with the NH2 atoms hidden
    visualize_residues 6 "resname ODN and z>90 and not name NH2" 2.0
    mol modcolor 6 top "ColorID 4"
    # Selecting the NH2 atoms of the ODA surfactants
    visualize_residues 7 "name NH2 and z > 90" 4.0
    mol modcolor 7 top "ColorID 3"
    # Selecting oil molecules
    visualize_residues 8 "resname D10 and z > 90 and (x+y+z)<320" 2.0

    # Reset the view
    display resetview
    display projection Orthographic
    axes location Off
    display depthcue on

    light 1 on
    light 2 on
    light 3 off
    light 4 off

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
    
    display resetview
    display projection Orthographic
    axes location Off
    display depthcue on

    light 1 on
    light 2 on
    light 3 off
    light 4 off

    scale by 1.6
    translate by 0 0 0

    pbc box
    pbc box -width 6 -color black
}

proc visualize_np {} {
    delete_all_reps
    visualize_residues 0 "resname COR" 1.5
    visualize_residues 1 "resname APT and not name N" 1.5
    mol modcolor 1 top "ColorID 2"
    # Selecting the NH3 atoms of the aptes
    visualize_residues 2 "name N" 2.0
    mol modcolor 2 top "ColorID 0"

    display resetview
    display projection Orthographic
    axes location Off
    display depthcue on

    light 1 on
    light 2 on
    light 3 off
    light 4 off

    scale by 1.6
    translate by 0 0 0

    pbc box
    pbc box -width 6 -color black
}

load_molecule "npt.gro"
delete_all_reps
visualize_system_face_cut
render_image "structure_100Oda.png"

delete_all_reps
mol delete all

load_molecule "npt.gro"
delete_all_reps
visualize_np_core
render_image "structure_core.png"

mol delete all

load_molecule "npt.gro"
delete_all_reps
visualize_np
render_image "structure_np.png"

exit