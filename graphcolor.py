states_graph = {
    'Tamil Nadu': ['Kerala', 'Karnataka'],
    'Kerala': ['Tamil Nadu'],
    'Karnataka': ['Tamil Nadu']
}

def graph_coloring(graph):
    colors_map = ['Red', 'Green', 'Blue']  # Real colors
    result = {}

    for state in graph:
        neighbor_colors = {result[neighbor] for neighbor in graph[state] if neighbor in result}
        for color in colors_map:
            if color not in neighbor_colors:
                result[state] = color
                break
    return result

# Example usage:
colors = graph_coloring(states_graph)
for state, color in colors.items():
    print(f"{state} is colored {color}")
