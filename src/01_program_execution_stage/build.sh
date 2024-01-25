echo "Enter a number:"
read number
if [ "$number" -eq 1 ]; then
    echo "Comparing the Regular Build and Static build size ."
    gcc src/program_execution_stage/main.cpp -o processed_files/program_execution_stage/regularBuild
    gcc -static src/program_execution_stage/main.cpp -o processed_files/program_execution_stage/staticBuild
    ls -lha processed_files/program_execution_stage 
else
    echo "see build.sh for choice."
fi