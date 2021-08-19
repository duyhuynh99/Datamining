def compare(a, b):
    return int(a[: -1]) + 1 == int(b[: -1])
if __name__ == "__main__":
    import numpy as np
    with open('config.txt', 'r') as f:
            min_pts = int(f.readline()[8:].strip())
            eps = float(f.readline()[8:].strip())
            print('epsilon = ', eps, 'minPts = ', min_pts)
    hits = 0
    with open('result/truth.txt', 'r') as f:
        truth = f.readlines()
    with open('result/preds.txt', 'r') as f:
        preds = f.readlines()
    
    if len(truth) != len(preds):
        print("[ERROR] 2 files don't have the same length")
    else:
        for a, b in zip(truth, preds):
            if a == b:
                hits += 1
        if hits == len(truth):
            print('[TEST] PASS')
        else:
            print('[TEST] FAILURE, Acuuracy rate:', hits/len(truth))