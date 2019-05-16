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


@InProceedings{pmlr-v97-mercado18a,
  title = 	 {Spectral Clustering of Signed Graphs via Matrix Power Means},
  author = 	 {Pedro Mercado and Francesco Tudisco and Matthias Hein},
  booktitle = 	 {Proceedings of the Thirty-sixth International Conference on Machine Learning},
  pages = 	 {-},
  year = 	 {2019},
  editor = 	 {Kamalika Chaudhuri and Ruslan Salakhutdinov},
  volume = 	 {97},
  series = 	 {Proceedings of Machine Learning Research},
  address = 	 {Long Beach, California},
  month = 	 {09--15 June},
  publisher = 	 {PMLR},
  pdf = 	 {-},
  url = 	 {-}
}

```
