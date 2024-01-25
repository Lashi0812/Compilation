#include <stdio.h>
#include "../static_lib/mylib.h"
#include "mydynlib.h"

void my_dynamic_function() {
    int add_result = add(5, 4);
    int mul_result = mul(5, 4);
    printf("Result from add: %d\nResult from mul: %d\n", add_result, mul_result);
}