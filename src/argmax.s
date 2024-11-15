.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)

    li t1, 0
    li t2, 1
loop_start:
    # TODO: Add your own implementation
    bge t2, a1, loop_end     # Exit loop if index >= length

    slli t3, t2, 2           # Calculate element offset
    add t4, a0, t3
    lw t5, 0(t4)             # Load element

    ble t5, t0, loop_continue # Skip if no update needed
    mv t0, t5                # Update max value
    mv t1, t2                # Update max index
    
loop_continue:
    addi t2, t2, 1           # Increment index
    j loop_start

loop_end:
    mv a0, t1                # Return max index
    jr ra
handle_error:
    li a0, 36
    j exit
