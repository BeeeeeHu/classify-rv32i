# Assignment 2: Classify

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
#### 1. `loop_start` - Main Loop Start
The main loop begins by checking if the current index `t1` has reached the upper limit `a2`. If `t1` is greater than or equal to `a2`, the loop ends. Otherwise, the program continues with the next steps.

#### 2. Initialization
Before entering the loop, two registers are initialized:
- `t2` is set to 0, which will be used as the counter for `stride_0` multiplication.
- `t3` is also set to 0 and will accumulate the results of `stride_0` multiplication.

#### 3. `mul_stride_0` - Stride 0 Multiplication Loop
The loop processes `stride_0` multiplication:
- While `t2` is less than `a3` (the stride count for this operation), the current index `t1` is added to `t3` (the accumulator). This simulates multiplying `t1` by `stride_0` by accumulating the values.
- `t2` is incremented on each iteration to track the number of operations performed.

Once `t2` reaches `a3`, the loop ends.

#### 4. `end_stride_0` - Compute Address and Load Element from `array_0`
After `stride_0` multiplication:
- The result in `t3` is multiplied by 4 (using a left shift operation) to convert it into a byte offset.
- This offset is added to the base address of `array_0` (held in `a0`), and the element at the computed address is loaded into `t4`.

#### 5. `mul_stride_1` - Stride 1 Multiplication Loop
The same process as `stride_0` is performed for `stride_1`:
- `t2` is reinitialized to 0, and `t3` is reset to 0.
- While `t2` is less than `a4` (the stride count for this operation), the current index `t1` is added to `t3` (accumulating for `stride_1`).
- Once `t2` reaches `a4`, the loop ends.

#### 6. `end_stride_1` - Compute Address and Load Element from `array_1`
After `stride_1` multiplication:
- The result in `t3` is converted into a byte offset by multiplying by 4.
- This offset is added to the base address of `array_1` (held in `a1`), and the element at the computed address is loaded into `t5`.

#### 7. `mul_loop` - Multiplication and Accumulation
In this loop:
- The program adds the value in `t5` (the element from `array_1`) to the accumulator `t2`.
- The counter `t3` is incremented to track the number of operations, and this continues until `t3` reaches `t4` (the number of elements in `array_0`).

#### 8. `end_mul` - Final Result Update
After the multiplication loop:
- The accumulated value in `t2` is added to the total in `t0`.
- The main loop index `t1` is incremented to move on to the next iteration.
- The program jumps back to `loop_start` to process the next iteration until `t1` reaches `a2`.

