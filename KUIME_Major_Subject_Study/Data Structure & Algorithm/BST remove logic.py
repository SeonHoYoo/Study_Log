class Node:
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None

class Bst:
    def __init__(self):
        self.root = None

    def insert(self, key):
        if self.root is None:
            self.root = Node(key)
        else:
            self._insert(self.root, key)

    def _insert(self, node, key):
        if key < node.key:
            if node.left is None:
                node.left = Node(key)
            else:
                self._insert(node.left, key)
        else:
            if node.right is None:
                node.right = Node(key)
            else:
                self._insert(node.right, key)

    def bst_remove(self, key):
        self.root, _ = self._remove_f(self.root, key)

    def _remove_f(self, t, key):
        if t is None:
            return None, None

        if key < t.key:
            t.left, removed = self._remove_f(t.left, key)
        elif key > t.key:
            t.right, removed = self._remove_f(t.right, key)
        else:
            removed = t
            if t.left is None:
                return t.right, removed
            elif t.right is None:
                return t.left, removed
            else:
                successor = self._min_value_node(t.right)
                t.key = successor.key
                t.right, _ = self._remove_f(t.right, successor.key)

        return t, removed

    def _min_value_node(self, node):
        current = node
        while current.left is not None:
            current = current.left
        return current

    def inorder(self):
        self._inorder(self.root)

    def _inorder(self, node):
        if node is not None:
            self._inorder(node.left)
            print(node.key, end=" ")
            self._inorder(node.right)

bst = Bst()

# 트리에 값 삽입
keys = [50, 30, 20, 40, 70, 60, 80]
for key in keys:
    bst.insert(key)

# 삭제 전 중위 순회 출력
print("삭제 전 중위 순회:")
bst.inorder()
print()

# 값 50 삭제
bst.bst_remove(50)

# 삭제 후 중위 순회 출력
print("삭제 후 중위 순회:")
bst.inorder()
print()