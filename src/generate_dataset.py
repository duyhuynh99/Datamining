import os
import numpy as np
from sklearn.datasets import make_blobs, make_moons, make_circles
import argparse

ap = argparse.ArgumentParser()
ap.add_argument('-n', '--num-samples', default = int(3e4), type = int, help = '# of the points need creating')
ap.add_argument('-c', '--centers', default = 5, type = int, help = '# of the centers')
ap.add_argument('-s', '--std', default = .5, type = float, help = 'std')
args = ap.parse_args()

if __name__ == "__main__":
    if not os.path.exists('datasets'):
        os.mkdir('datasets')
    p = np.random.rand()
    if p < .2:
        X, y = make_blobs(n_samples = args.num_samples, centers = args.centers, n_features = 2, cluster_std = args.std)
    elif p < .4:
        X, y = make_moons(n_samples = args.num_samples, noise=.05)
    elif p < .6:
        X, y = make_circles(n_samples = args.num_samples, factor=.5, noise=.05)
    elif p < .8:
        _X, y = make_blobs(n_samples = args.num_samples, random_state=170)
        transformation = [[0.6, -0.6], [-0.4, 0.8]]
        X = np.dot(_X, transformation)
    else:
        X, y = make_blobs(n_samples = args.num_samples, cluster_std=[1.0, 2.5, 0.5], random_state = 170)

    with open(os.path.join('datasets', 'data.txt'), 'w') as f:
        f.write(f'{X.shape[0]}' + '\n')
        for x in X:
            f.write(f'{x[0]}, {x[1]}\n')