import numpy as np
import os
import matplotlib.pyplot as plt

def load_data():
    X = []
    with open('datasets/data.txt', 'r') as f:
        line = f.readline()
        while line:
            nums = line.split(',')
            if len(nums) == 2:
                X.append((float(nums[0]), float(nums[1])))
            line = f.readline()
    return np.array(X).astype(np.float32)

def load_cluster(filepath):
    y = []
    with open(filepath, 'r') as f:
        line = f.readline()
        while line:
            y.append(int(line))
            line = f.readline()
    return np.array(y)

def visualize(X, y, filename):
    for i, lb in enumerate(np.unique(y)):
        plt.scatter(X[y == lb, 0], X[y == lb, 1], c = colors[i % 7])
    plt.savefig(f'images/{filename}')
    plt.clf()

if __name__ == "__main__":
    colors = ['c', 'b', 'r', 'y', 'k', 'purple', 'olive', 'gold', 'indigo', 'tan', 'slategrey', 'crimson']
    X = []
    truth = []
    preds = []
    X = load_data()
    truth = load_cluster('result/truth.txt')
    preds = load_cluster('result/preds.txt')
    if not os.path.exists('images'):
        os.mkdir('images')
    visualize(X, truth, 'truth.png')
    visualize(X, preds, 'preds.png')