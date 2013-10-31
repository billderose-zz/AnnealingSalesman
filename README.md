AnnealingSalesman
=================

We use a naive simulated annealing algorithm to solve the traveling salesman problem.
We randomly generate *n* cities in the unit square. When *n* = 10, we have an image like this:

![ten cities bad](/solutions/ten_bad.jpeg)

We then run the simulated annealing, and observe the optimization of the path length:

![ten path length](/solutions/ten_path.jpeg)

Ultimately, our goal is to find the shortest path starting and ending at the same city. In this case, we are
left with the solution:

![ten cities bad](/solutions/ten_good.jpeg)

