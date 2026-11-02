# Final Performance Evaluation: Multi-Threaded Quicksort

### 1. Experimental Design and Statistical Rigor
The original benchmarking protocol mentioned in the project had many issues according to our observations. Only executing a test five times for each size can create system noise and background processes to compromise the integrity of the test. We modified the test to perform numerous repetitions (25, 50 and 100) for different array sizes ranging from 1,000 elements to a load of 5,000,000 elements. To account for thermal throttling of the CPU, we randomized the order of the tests as well.

The huge volume of data captured allowed us to calculate relatively small 95% confidence intervals. The thin shading in the primary visualization represents the variance for 100 individual runs and demonstrates how small the variation was for each individual test. The differences in performance we illustrated were not isolated spikes, but were statistically significant.

![Performance Evaluation Plot](data/final_performance_plot.png)

### 2. Threshold Analysis and the 400,000 Claim
The initial theory told us that the parallel implementation would cross over the sequential baseline at around 400,000 elements. The data also suggested that the hardware architecture is the primary factor dictating where this threshold occurs.

On the Mac laptops with unified memory (M1, M4, and M4 Pro), the parallel algorithm outweighs sequential and libc implementations before 500,000 elements. The Windows laptop also supports this phenomenon, but the cross over occurs at a larger element size. On the contrary, the parallel code on the Linux Xeon server never crosses over the single-threaded baselines of any size.

### 3. Continuous Trends and Extrapolation
If we scale array sizes to the power of 2, we can generate an accurate prediction of performance beyond the 5,000,000 element limit. On the machines, the trend line for the parallel implementation favors positive slope and closely approaches the baseline at larger element sizes. It is rational to presume that this favorable trend line would continue and the parallel implementation of the algorithm would approach the baseline at even larger element sizes.

We might expect the Xeon server to behave similarly to the other machines, but this is not the case. The Xeon server parallel trend line aggressively curves upward. It is rational to expect that the parallel implementation of the algorithm on the Xeon server would approach the baseline, but at very large element sizes, the approach would be very inefficient and time savings would be severely compounded.

### 4. Hardware Architecture and The Server Penalty
The biggest discovery we had of this project was the massive performance failure of the Linux Xeon machine, which is illustrated in the below graph. At a peak load of 5,000,000, the green parallel bar dominates the Linux server performance graph. It is also the shortest bar on all the other machines.

![Execution Time at 5,000,000 Array Size](data/5M_array_comparison.png)

It is a common perception that a powerful server specifications or GPU will speed up all workloads. This particular quicksort implementation runs entirely on the CPU, so the server’s poor performance is due to thread management overhead despite having the most powerful GPU. Enterprise servers like Xeon have multiple physical processors which are further spread across multiple memory zones. Compared to the time saved by breaking the array into smaller pieces to quicksort, the OS has to do a lot of work to create and manage threads across memory zones. The array could be quicksorted using the standard library (libc) implementation and still be faster than the custom threaded implementation.

### 5. Final Verdict
Due to its volatile nature, the custom multi-threaded quicksort cannot be generally adopted. This quicksort breaks down on enterprise servers. Due to its hardware dependency, it should not be used to replace the libc qsort in a general production environment.