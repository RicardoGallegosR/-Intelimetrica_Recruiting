import numpy as np

def count(data: list) -> int:
    return len(data)

def avg(data: list)->float:
    if len(data) == 0:
        raise ValueError("The data list must contain at least one number")
    return np.mean(data)

def std(data: list) -> float:
    if len(data) == 0:
        raise ValueError("The data list must contain at least one number")
    return np.std(data)