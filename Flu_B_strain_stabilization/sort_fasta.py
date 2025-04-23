import re

# Read the FASTA file
with open("trimer_relaxed_0001_chA.fa", "r") as f:
    lines = f.readlines()

# Parse the sequences
sequences = []
current_header = ""
current_sequence = []

for line in lines:
    line = line.strip()
    if line.startswith(">"):  # Header line
        if current_header:  # Store the previous sequence
            sequences.append((current_header, "".join(current_sequence)))
        current_header = line
        current_sequence = []
    else:
        current_sequence.append(line)

# Append the last sequence
if current_header:
    sequences.append((current_header, "".join(current_sequence)))

# Extract global_score from headers using regex
def extract_score(header):
    match = re.search(r"global_score=([\d.]+)", header)
    return float(match.group(1)) if match else float('-inf')  # Default to lowest if not found

# Sort sequences by global_score (descending order)
sequences.sort(key=lambda x: extract_score(x[0]), reverse=False)

# Write sorted sequences to a new FASTA file
with open("sorted_output.fasta", "w") as f:
    for header, seq in sequences:
        f.write(f"{header}\n")
        f.write(f"{seq}\n")

print("Sequences sorted by global_score and saved to 'sorted_output.fasta'.")

