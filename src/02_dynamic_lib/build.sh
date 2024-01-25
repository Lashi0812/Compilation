echo "Enter a number:"
echo "1 - Building static lib without -fPIC flag ."
echo "2 - Building static lib with -fPIC flag ."
echo "3 - Building dynamic lib and linking the static lib ."
echo "4 - Compiling the main file with dynamic library."
echo "5 - Running the main executable."
read number
script_dir="$(dirname "$(readlink -f "$0")")"
build_dir="$script_dir/build"
if [ ! -d "$build_dir" ]; then
    mkdir -p "$build_dir"
fi

if [ "$number" -eq 1 ]; then
    echo "Building static lib without -fPIC flag ."

    echo "Executing : gcc -c $script_dir/static_lib/add.cpp -o $build_dir/add.o"
    gcc -c $script_dir/static_lib/add.cpp -o $build_dir/add.o

    echo "Executing : gcc -c $script_dir/static_lib/mul.cpp -o $build_dir/mul.o"
    gcc -c $script_dir/static_lib/mul.cpp -o $build_dir/mul.o

    echo "Executing : ar rcs $build_dir/libstaticlib.a $build_dir/add.o $build_dir/mul.o"
    ar rcs $build_dir/libstaticlib.a $build_dir/add.o $build_dir/mul.o 

    echo "Created the static library without -fPIC  at $build_dir/libstaticlib.a"
elif [ "$number" -eq 2 ]; then
    echo "Building static lib with -fPIC flag ."

    echo "Executing : gcc -c -fPIC $script_dir/static_lib/add.cpp -o $build_dir/add.o"
    gcc -c -fPIC $script_dir/static_lib/add.cpp -o $build_dir/add.o

    echo "Executing : gcc -c -fPIC $script_dir/static_lib/mul.cpp -o $build_dir/mul.o"
    gcc -c -fPIC $script_dir/static_lib/mul.cpp -o $build_dir/mul.o

    echo "Executing : ar rcs $build_dir/libstaticlib.a $build_dir/add.o $build_dir/mul.o"
    ar rcs $build_dir/libstaticlib.a $build_dir/add.o $build_dir/mul.o 

    echo "Created the static library with -fPIC  at $build_dir/libstaticlib.a"
elif [ "$number" -eq 3 ]; then
    echo "Building dynamic lib and linking the static lib ."

    echo "Executing : gcc -shared -fPIC $script_dir/dynamic_lib/mydynlib.cpp -L$build_dir -lstaticlib -o $build_dir/libmydynlib.so"
    gcc -shared -fPIC "$script_dir/dynamic_lib/mydynlib.cpp" -L$build_dir -lstaticlib -o $build_dir/libmydynlib.so

    echo "Created the dynamic library and linked with static library"
elif [ "$number" -eq 4 ]; then
    echo "Compiling the main file with dynamic library."

    echo "Exectuing : gcc $script_dir/main/main.cpp -L$build_dir -lmydynlib -Wl,-rpath,$build_dir -o $build_dir/main"
    gcc $script_dir/main/main.cpp -L$build_dir -lmydynlib -Wl,-rpath,$build_dir -o $build_dir/main

    echo "Compiled the main file at $build_dir/main"
elif [ "$number" -eq 5 ]; then
    echo "Running the main executable."
    $build_dir/main
else
    echo "see build.sh for choice."
fi