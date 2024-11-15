# Assignment 2: Classify

Abs
---
1. **`sub t0, zero, t0`**  
   This instruction negates the value in `t0`. If `t0` was `5`, it becomes `-5`; if it was `-3`, it becomes `3`.

2. **`sw t0, 0(a0)`**  
   This stores the value in `t0` (after it was negated) into the memory location at the address stored in `a0`.


---

ReLU
---

### Task: Replace Negative Elements in an Array

The goal is to replace all negative elements in a memory array with 0, while leaving positive and zero elements unchanged.  

#### Logic Overview:
1. **Iterate Through the Array**:  
   Use a loop to traverse each element in the array sequentially.

2. **Check Element Value**:  
   - If an element’s value is less than 0, update it to 0.  
   - Otherwise, leave the element unchanged.  

3. **Address Calculation**:  
   Use an offset to calculate the memory address of each array element, ensuring every element is processed in order.  

---

ArgMax
---
Initialization:
Start with the first element as the current maximum value.

Comparison:
Sequentially compare each subsequent element with the current maximum.

Update:
If a strictly larger value is found, update the current maximum and its index.
Skip the update if the current value is less than or equal to the maximum.
Termination:
Continue until all elements are checked. Return the index of the maximum value.

#### Initialization
- The maximum value (`t0`) is initialized with the first element.  
- The maximum index (`t1`) is set to 0.  
- The loop index (`t2`) starts at 1 to avoid re-checking the first element.

#### Loop Termination
- The loop continues as long as the loop index (`t2`) is less than the array length (`a1`).  
- When `t2` equals or exceeds `a1`, the loop ends with `bge t2, a1, loop_end`.

#### Element Address Calculation
- The offset for the current element is calculated as `t3 = t2 * 4` (since each element is 4 bytes).  
- The element's memory address is then determined by adding the offset to the base address (`a0`).

#### Element Loading and Comparison
- The current element is loaded into `t5` from memory.  
- The value in `t5` is compared with the current maximum (`t0`).  
  - If the current element is **less than or equal** to the maximum, the loop skips updating the maximum (`ble t5, t0, loop_continue`).

#### Update Maximum
- If a strictly larger value is found:
  - The maximum value (`t0`) is updated to the value in `t5`.  
  - The maximum index (`t1`) is updated to the current index (`t2`).

#### Loop Continuation
- The loop index (`t2`) is incremented, and the process repeats until all elements are processed.

---
  
Dot Product
---

1. **Main Loop Start and Initialization**:  
   The loop checks if the current index `t1` has reached the upper limit `a2`. If not, it initializes registers `t2` and `t3` to 0. `t2` will count operations, and `t3` will accumulate values for multiplication.

2. **Stride Multiplication and Element Loading**:  
   For both `stride_0` and `stride_1`, the program performs multiplications, accumulating the results into `t3`. After each stride, it calculates the byte offset and loads the corresponding elements from `array_0` and `array_1` into `t4` and `t5`.

3. **Multiplication and Accumulation**:  
   The values from `array_0` and `array_1` are multiplied, and the results are accumulated in `t2`.

4. **Final Result Update**:  
   The accumulated result in `t2` is added to the total in `t0`. The loop index `t1` is then incremented, and the process continues until all elements are processed, resulting in the dot product.

---

Matrix Multiplication 
---

#### Inner Loop (`inner_loop_end`)

At the end of the inner loop, the program prepares to move to the next row in the matrix. First, it calculates the byte offset needed to move to the next row by multiplying the number of columns (`a2`) by 4 (since each element is 4 bytes). This offset is added to the current row pointer (`s3`) to point to the next row in memory. The row counter (`s0`) is then incremented to track the progress of the rows being processed. The program then jumps back to the start of the outer loop to continue the next iteration.

#### Outer Loop (`outer_loop_end`)

Once the outer loop completes, the epilogue section restores the saved registers and prepares for returning from the function. The program retrieves the saved values of the registers (`ra`, `s0` through `s5`) from the stack, adjusts the stack pointer to remove them, and then jumps back to the return address stored in `ra`. This ensures the program can return to the caller with the correct state, having restored the necessary register values.

---

Read Matrix
---
This code implements multiplication through repeated addition. It starts by initializing `s1` to 0 and setting `t3` as a counter equal to `t1`. In the loop, the value of `t2` is added to `s1` in each iteration, and `t3` is decremented until it reaches zero. Once `t3` is zero, the loop ends, and the accumulated result (which is the product of `t2` and `t1`) is stored in `s1`. Essentially, this code multiplies `t2` by `t1` using repeated addition.

---

Write Matrix
---

This code performs multiplication through repeated addition. It starts by initializing `s4` to 0 and copying the value of `s2` into `t1` to set up the loop counter. In the loop, the value in `s3` is added to `s4` on each iteration, and `t1` is decremented until it reaches zero. When `t1` becomes zero, the loop ends, and the result of the repeated addition (which is the product of `s3` and `s2`) is stored in `s4`. This is a manual implementation of multiplying `s3` by `s2` using addition.
