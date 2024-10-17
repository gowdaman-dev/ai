# water jug problem using BFS (Breadth-First Search)
from collections import deque
def waterjug(x, y, z):
    # Create a queue and visited set
    queue = deque([(0, 0)])
    visited = set((0, 0))
    # Loop through the queue
    while queue:
        a, b = queue.popleft()
        # Check if the target volume is reached
        if a == z or b == z or a + b == z:
            return True
        # Check all possible moves
        moves = [
            (x, b),  # Fill jug 1
            (a, y),  # Fill jug 2
            (0, b),  # Empty jug 1
            (a, 0),  # Empty jug 2
            (min(a + b, x), 0) if a + b >= x else (a + b, 0),  # Pour jug 1 to jug 2
            (0, min(a + b, y)) if a + b >= y else (0, a + b)  # Pour jug 2 to jug 1
        ]

        # Add all valid moves to the queue
        for move in moves:
            if move not in visited:
                queue.append(move)
                visited.add(move)

    return False

# Test the function
print(waterjug(4, 3, 2))  # True