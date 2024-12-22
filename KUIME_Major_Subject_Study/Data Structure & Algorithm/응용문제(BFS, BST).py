# 특정 거리의 도시 찾기 - BFS 적용 (deque 적용)
from collections import deque

def shortest_city(graph, n, m, k, x):
    distance = [-1] * (n + 1)
    distance[x] = 0

    queue = deque([x])

    while queue:
        current_city = queue.popleft()

        for next_city in graph[current_city]:
            if distance[next_city] == -1:
                distance[next_city] = distance[current_city] + 1
                queue.append(next_city)

    result = [i for i in range(1, n + 1) if distance[i] == k]
    return result

n, m, k, x = map(int, input('Enter input values (n m k x): ').split())
graph = [[] for _ in range(n + 1)]

print("Enter road connections:")
for _ in range(m):
    a, b = map(int, input().split())
    graph[a].append(b)

cities = shortest_city(graph, n, m, k, x)
print("결과:", *cities)

# 가래떡을 원하는 길이의 합이 되도록 자르는 프로그램 - 이진탐색활용

class Node:
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None

class BST:
    def __init__(self):
        self.root = None

    def insert(self, t, key):
        if t is None:
            return Node(key)
        if key < t.key:
            t.left = self.insert(t.left, key)
        else:
            t.right = self.insert(t.right, key)
        return t

    def inorder(self, t):
        if t:
            self.inorder(t.left)
            print(t.key, end=" ")
            self.inorder(t.right)

def find_max_height(rice_cakes, target):
    start = 0
    end = max(rice_cakes)
    result = 0

    while start <= end:
        mid = (start + end) // 2
        total = sum((rc - mid if rc > mid else 0) for rc in rice_cakes)

        if total >= target:
            result = mid
            start = mid + 1
        else:
            end = mid - 1

    return result

n, m = map(int, input("떡의 개수와 요청된 떡 길이 : ").split())
rice_len = list(map(int, input(f"{n}개의 떡 길이 : ").split()))

bst = BST()
for rc in rice_len:
    bst.root = bst.insert(bst.root, rc)

max_height = find_max_height(rice_len, m)
print(f"최적 절단기 높이: {max_height}")