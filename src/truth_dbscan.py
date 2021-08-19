import os
import numpy as np
from sklearn.cluster import DBSCAN
import time

if __name__ == "__main__":
    with open('runtime/py_runtime_points.txt', 'w') as f1:
        X = []
        with open('datasets/data.txt', 'r') as f:
            line = f.readline()
            while line:
                nums = line.split(',')
                if len(nums) == 2:
                    X.append((float(nums[0]), float(nums[1])))
                line = f.readline()
        X = np.array(X).astype(np.float32)
        with open('config.txt', 'r') as f:
            min_pts = int(f.readline()[8:].strip())
            eps = float(f.readline()[8:].strip())
        start = time.time()
        dbscan = DBSCAN(eps = eps, min_samples = min_pts).fit(X)
        end = time.time()
        clusters = dbscan.labels_
        with open('result/truth.txt', 'w') as f:
            for c in clusters:
                f.write(f'{c + 1}\n')
        f1.write(f'{round(end - start, 4)}')
        if os.path.exists('runtime/improved_runtime_points.txt'):
            with open('runtime/improved_runtime_points.txt', 'r') as f:
                print('[Improved DBSCAN] Elapsed time:', f.readline(), 's')
        if os.path.exists('runtime/origin_runtime_points.txt'):
            with open('runtime/origin_runtime_points.txt', 'r') as f:
                print('[Original DBSCAN] Elapsed time:', f.readline(), 's')

        print('[DBSCAN Python] Elapsed time:', f'{round(end - start, 4)}', 's')