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
