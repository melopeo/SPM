## Spectral Clustering of Signed Graphs via Matrix Power Means

MATLAB implementation of the paper:

[P. Mercado, F. Tudisco, and M. Hein, Spectral Clustering of Signed Graphs via Matrix Power Means. In ICML 2019.](https://melopeo.github.io/)

## Content:
- `example.m` : contains an easy example showing how to use the code

- `experiments_main.m` : runs experiments contained in our [paper](http://proceedings.mlr.press/v84/mercado18a/mercado18a.pdf)
 
## Usage:
Let `Wcell` be a cell with the adjacency matrices of each layer , `p` the power of the power mean Laplacian, `numClusters` the desired number of clusters. Clusters through the power mean Laplacian `L_p` are computed via
```
C = clustering_multilayer_graphs_with_power_mean_laplacian(Wcell, p, numClusters);
```
## Quick Overview:
![](https://github.com/melopeo/PM/blob/master/PaperAndPoster/ThePowerMeanLaplacianForMultilayerGraphClusteringPoster.jpg)

## Citation:
```


@InProceedings{pmlr-v97-mercado18a,
  title = 	 {Spectral Clustering of Signed Graphs via Matrix Power Means},
  author = 	 {Pedro Mercado and Francesco Tudisco and Matthias Hein},
  booktitle = 	 {Proceedings of the Thirty-sixth International Conference on Machine Learning},
  pages = 	 {1828--1838},
  year = 	 {2019},
  editor = 	 {Kamalika Chaudhuri and Ruslan Salakhutdinov},
  volume = 	 {97},
  series = 	 {Proceedings of Machine Learning Research},
  address = 	 {Long Beach, California},
  month = 	 {09--15 June},
  publisher = 	 {PMLR},
  pdf = 	 {-},
  url = 	 {-},
  abstract = 	 {Signed graphs encode positive (attractive) and negative (repulsive) relations between nodes. We extend spectral clustering to signed graphs  via the one-parameter family of Signed Power Mean Laplacians, defined as the matrix power mean of normalized standard and signless Laplacians of positive and negative edges. We provide a thorough analysis of the proposed approach in the setting of a general Stochastic Block Model that includes models such as the Labeled Stochastic Block Model and the Censored Block Model. We show that in expectation the signed power mean Laplacian captures the  ground truth clusters under reasonable settings where state-of-the-art approaches fail. Moreover, we prove that the eigenvalues and  eigenvector of the signed power mean Laplacian concentrate around their expectation under reasonable conditions in the general Stochastic Block Model. Extensive experiments on random graphs and real world datasets confirm the theoretically predicted behaviour of the signed power mean Laplacian and show that it compares favourably with state-of-the-art methods.}
}

```
