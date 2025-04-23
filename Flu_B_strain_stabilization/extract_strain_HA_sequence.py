import numpy as np
import pandas as pd
from Bio import Entrez, SeqIO

b_strain_data = pd.read_excel('FluAntigen/DataSet/D_B.xlsx')

Entrez.email = "akshay@popvax.com"
def fetch_sequences(strain):
    handle = Entrez.esearch(db="nucleotide", term=str(strain) + " AND hemagglutinin", retmax=10)
    record = Entrez.read(handle)
    seqid = record["IdList"]
    ha_proteins = []
    for sequence in seqid:
        a = Entrez.efetch(db="nucleotide", id=sequence, rettype="gb", retmode="text")
        na_gene = SeqIO.read(a, "gb")
        a.close()
        for feature in na_gene.features:
            if feature.type == "CDS":
                try:
                    ha_proteins.append(feature.qualifiers["translation"])
                except:
                    pass
    l = [len(str(i)) for i in ha_proteins]
    if len(l) == 0:
        print("No HA protein found for this strain")
        return None
    else:
        return ha_proteins[np.argmax(l)][0]

unique_values = pd.concat([b_strain_data['VirusStrain'], b_strain_data['SerumStrain']]).unique()
strains = pd.DataFrame(unique_values, columns=['Strain'])

for index, row in strains.iterrows():
    print(row.Strain)
    val = 0
    try:
        ha = fetch_sequences(row.Strain)
    except:
        ha = None
    if ha is None:
        val = 1
        try:
            ha = fetch_sequences("/".join(row.Strain.split('/')[:3]))
        except:
            ha = None
        if ha is None:
            val = 2
            try:
                ha = fetch_sequences("/".join(row.Strain.split('/')[:2]))
            except:
                ha = None
    strains.at[index, 'Strain_HA'] = ha
    strains.at[index, 'Accuracy'] = val
    
    if index == 0:
        strains.iloc[[index]].to_csv('Strain_HA_sequence.csv', mode='w', index=False, header=True)
    else:
        strains.iloc[[index]].to_csv('Strain_HA_sequence.csv', mode='a', index=False, header=False)