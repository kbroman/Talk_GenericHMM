## Proposed text

It's great to be back at the CTC. I'm talking about a generic model for genotype reconstruction in multi-parent populations

There's a wide variety of multi-parent populations, including recombinant inbred lines like the mouse Collaborative Cross and MAGIC lines in plants, and advanced intercrosses like heterogeneous stock and diversity outbred mice.

A key step in their use to reconstruct the founder alleles along the chromosomes. Here is a 1 Mbp region of SNP genotypes in the 8 founder strains and in a single diversity outbred mouse. We use this data to calculate the probability of each of the 36 possible genotypes, and then we can threshold those probabilities to get inferred genotypes.

You could skip this genotype reconstruction and just do a t-test at each SNP, as in GWAS. Using the inferred founder haplotypes can be more powerful, and the reconstructed genomes can be useful for diagnostic purposes.

Here's an example reconstruction genome for one DO mouse. This is what we're trying to figure out.

The main methods use a hidden Markov model. We have an underlying Markov chain of unobserved diplotypes G_i, and then the observed SNP genotypes. There are three sets of parameters that govern the model: the initial and transition probabilities concern the pattern of genotypes on the MPP chromosomes, and the emission probabilities relate the underlying genotypes to the observed SNP genotypes (basically concerning a model for SNP genotyping errors).

I've spent a bunch of time characterizing the process on MPP chromosomes. I mean a lot of time. The R/qtl2 package includes implementations for a variety of different types of populations, but these exact calculations can be tedious, they're maybe not necessary.

So here I'd like to propose a generic model that could be applied broadly. Imagine a founder population of k inbred lines in known proportions, and n discrete generations of random mating in huge populations. We can calculate the transition probabilities in this case, and we can use these equations broadly. s need to specify the relative proportions of the founders, which is likely obvious from the design of  the population, plus the effective number of generations of random mating, which might be calibrated through the observed map expansion, which is the proportional increase in recombination breakpoints. In a complex design, you could determine this from computer simulation.

If we apply this generic model in diversity outbred mice, the differences are negligible. This is the genome scan for a trait using probabilities from the two methods, and the results are hard to distinguish, with the largest difference in LOD score being about 0.01.

If we apply this approach to Collaborative Cross data, the genotype probabilities for the autosomes are similarly indistinguishable, while fo the X chromosome there are some important differences, as the exact model will exclude three of the eight founders. For example, here are the genotype probabilities along the X chromosome for the CC038 line. With the approximate model, there's a segment at around 135 Mbp that could either be B6 or NOD, but B6 is excluded by the design of the cross.

That is because of the behavior of the X chromosome in the Collaborative Cross. For a line formed with the cross AxBxCxDxExFxGxH, always listing females first, the X chromosome will not include D, G, or H, and the contribution of C will, on average, be double that of each of A, B, E, and F.

In summary, I'm proposing a generic model for genome reconstruction in multi-parent populations. You need to specify the relative proportions of the founders and the effective number of generations of random mating. The basic conclusion here is that the Richard Mott's HAPPY software is broadly effective, and we need not get all fancy. The only thing I'm adding here is an allowance for founders to contribute in different proportions. A paper on the work is at bioRxiv.
