# Loading data and getting residues around nanoparticle
set filename "/scratch/saeed/GÖHBP/PRE_DFG_4Mar2024/single_np/vmd_test/15Oda/npt.gro"
puts "Attempting to load file: $filename"

# Load the molecule
set mol [mol load gro $filename]
# Define the distance as a variable
set distance 3
# Find all residues within 3 Å of APT or COR, including APT and COR themselves
set inRadiusResidues [atomselect top "within $distance of (resname APT or resname COR)"]

# Get the unique residue IDs for these molecules
set resIDs [$inRadiusResidues get residue]
set uniqueResIDs [lsort -unique $resIDs]

# Now select all atoms that belong to these residues
set completeInRadiusResidues [atomselect top "residue $uniqueResIDs"]

# Write the selected molecules to a GRO file
$completeInRadiusResidues writegro "all_including_apt_cor_near_apt_cor.gro"

# Cleanup
$inRadiusResidues delete
$completeInRadiusResidues delete

exit
