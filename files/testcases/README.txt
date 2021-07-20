These are test cases for Fokker-Planck that cause errors under normal operation.

Case 1: Density drops to zero when a peak starts near grid boundaries then moves away from the boundary.
Potential Solution: Iterative grid selection... when you notice a peak near a grid boundary, literally start over and move the grid to cover that area
	(just make sure the solution is in the interior).