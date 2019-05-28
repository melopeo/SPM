## Spectral Clustering of Signed Graphs via Matrix Power Means

MATLAB implementation of the paper:

[P. Mercado, F. Tudisco, and M. Hein, Spectral Clustering of Signed Graphs via Matrix Power Means. In ICML 2019.](https://arxiv.org/pdf/1905.06230v1.pdf)

## Content:
- `example.m` : contains an easy example showing how to use the code

- `experiments_main.m` : runs experiments contained in our [paper](https://arxiv.org/pdf/1905.06230v1.pdf)
 
## Usage:
Let `Wcell` be a cell with the adjacency matrices of each layer , `p` the power of the power mean Laplacian, `numClusters` the desired number of clusters. Clusters through the power mean Laplacian `L_p` are computed via
```
C = clustering_signed_graphs_with_power_mean_laplacian(Wcell, p, numClusters);
```

## Citation:
```
@InProceedings{pmlr-v97-mercado19a,
  title = 	 {Spectral Clustering of Signed Graphs via Matrix Power Means},
  author = 	 {Mercado, Pedro and Tudisco, Francesco and Hein, Matthias},
  booktitle = 	 {Proceedings of the 36th International Conference on Machine Learning},
  pages = 	 {4526--4536},
  year = 	 {2019},
  editor = 	 {Chaudhuri, Kamalika and Salakhutdinov, Ruslan},
  volume = 	 {97},
  series = 	 {Proceedings of Machine Learning Research},
  address = 	 {Long Beach, California, USA},
  month = 	 {09--15 Jun},
  publisher = 	 {PMLR},
  pdf = 	 {http://proceedings.mlr.press/v97/mercado19a/mercado19a.pdf},
  url = 	 {http://proceedings.mlr.press/v97/mercado19a.html},
  abstract = 	 {Signed graphs encode positive (attractive) and negative (repulsive) relations between nodes. We extend spectral clustering to signed graphs via the one-parameter family of Signed Power Mean Laplacians, defined as the matrix power mean of normalized standard and signless Laplacians of positive and negative edges. We provide a thorough analysis of the proposed approach in the setting of a general Stochastic Block Model that includes models such as the Labeled Stochastic Block Model and the Censored Block Model. We show that in expectation the signed power mean Laplacian captures the ground truth clusters under reasonable settings where state-of-the-art approaches fail. Moreover, we prove that the eigenvalues and eigenvector of the signed power mean Laplacian concentrate around their expectation under reasonable conditions in the general Stochastic Block Model. Extensive experiments on random graphs and real world datasets confirm the theoretically predicted behaviour of the signed power mean Laplacian and show that it compares favourably with state-of-the-art methods.}
}

```
