# Loading data and getting residues around nanoparticle
set filename "/scratch/saeed/GÖHBP/PRE_DFG_4Mar2024/single_np/vmd_test/15Oda/npt.gro"
puts "Attempting to load file: $filename"

# Load the molecule
set mol [mol load gro $filename]

# Find water residues within 3 Å of APT or COR
set waterResidues [atomselect top "resname SOL and within 3 of (resname APT or resname COR)"]

# Get the unique residue IDs for these water molecules
set waterResIDs [$waterResidues get residue]
set uniqueWaterResIDs [lsort -unique $waterResIDs]

# Now select all atoms that belong to these residues
set completeWaterResidues [atomselect top "resname SOL and residue $uniqueWaterResIDs"]

# Write the selected water molecules to a PDB file
$completeWaterResidues writepdb "waters_near_apt_cor.pdb"

# Cleanup
$waterResidues delete
$completeWaterResidues delete

exit