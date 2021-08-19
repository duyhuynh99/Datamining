import matplotlib.pyplot as plt
import numpy as np
import os

def load_cluster(filepath):
    y = []
    with open(filepath, 'r') as f:
        line = f.readline()
        while line:
            for i in line.split(','):
                y.append(float(i.strip())) 
            line = f.readline()
            
    return np.array(y)

if __name__ == "__main__":
    num_pts = [10000, 20000, 30000, 40000, 50000]
    py_runtime = []
    kdtree_pas_runtime = []
    ori_pas_runtime = []

    all_runtime = []
    for i in range (1,6):
        py_runtime.append(load_cluster('py_runtime_' + str(10000*i) + '_points.txt'))
        kdtree_pas_runtime.append(load_cluster('runtime_' + str(10000*i) + '_points.txt'))
        ori_pas_runtime.append(load_cluster('origin_runtime_' + str(10000*i) + '_points.txt'))
    for i in range (0,5):    
        plt.plot(num_pts, np.array(py_runtime)[:, i],'r-',label='Scikit-learn DBSCAN', marker='o')
        plt.plot(num_pts, np.array(kdtree_pas_runtime)[:, i],'b-',label='Kd-Tree DBSCAN', marker='o')
        plt.plot(num_pts, np.array(ori_pas_runtime)[:, i],'g-',label='Original DBSCAN', marker='o')
        plt.ylabel('Elapse time')
        plt.xlabel('Number of points')
        plt.xticks(np.arange(10000, 55000, step=10000))
        plt.legend()
        plt.savefig(f'images/runtime_dataset{i + 1}.png')
        plt.clf()