## Proposed text

I'm talking about a generic model for genotype reconstruction in multi-parent populations

There's a wide variety of multi-parent populations, including recombinant inbred lines like the mouse Collaborative Cross and MAGIC lines in plants, and advanced intercrosses like heterogeneous stock and diversity outbred mice. A key step is to reconstruct the founder alleles along the chromosomes.

This is a 1 megabase region with SNP genotypes in the 8 founders and one diversity outbred mouse. We use this data to calculate the probability of each possible genotype. You can threshold those probabilities to get inferred genotypes.

You could skip genotype reconstruction and just do a t-test at each SNP, as in GWAS. Using the inferred founder haplotypes can be more powerful, and the reconstructed genomes can be useful for diagnostic purposes.

Here's an example reconstruction for a DO mouse. This is what we're trying to figure out.

The main methods use a hidden Markov model. The underlying genotypes form a Markov chain, but what we observe are the SNP genotypes. Three sets of parameters govern the model: the initial and transition probabilities concern the pattern of genotypes on the MPP chromosomes, while the emission probabilities concern a model for SNP genotyping errors.

I've spent a bunch of time characterizing the process on MPP chromosomes. I mean a lot of time. The R/qtl2 package includes implementations for a variety of crosses, but these exact calculations can be tedious.

So here I propose a generic model that could be applied broadly. Imagine a founder population of k inbred lines in known proportions, and n discrete generations of random mating in huge populations. We can calculate the transition probabilities in this case. You need to specify the relative proportions of the founders, which is likely obvious from the design of the population, plus the effective number of generations of random mating, which might be calibrated through the observed map expansion, which is the proportional increase in recombination breakpoints. In a complex design, you could determine this from computer simulation.

If we apply this generic model in diversity outbred mice, the differences are negligible. This is the genome scan for a trait using probabilities from the two methods, and the results are hard to distinguish, with the largest difference in LOD score being about 0.01.

If we apply this approach to Collaborative Cross data, the genotype probabilities for the autosomes are indistinguishable, while for the X chromosome there are some important differences, as the exact model will exclude three of the eight founders. For example, here are the genotype probabilities along the X chromosome for the CC038 line. With the approximate model, there's a segment at around 135 Mbp that could either be B6 or NOD, but B6 is excluded by the design of the cross.

That is because of the behavior of the X chromosome in the Collaborative Cross. Depending on the order of the cross, the X chromosome will not include strains in positions D, G, or H, and the contribution of C will, on average, be double that of each of A, B, E, and F.

In summary, I'm proposing a generic model for genome reconstruction in multi-parent populations. You need to specify the relative proportions of the founders and the effective number of generations of random mating. The basic conclusion here is that the Richard Mott's HAPPY software is broadly effective, and we need not get all fancy. The only thing I'm adding here is an allowance for founders to contribute in different proportions. A paper on the work is at bioRxiv.
