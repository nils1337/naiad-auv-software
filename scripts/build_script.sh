#!/bin/bash

function BuildProject
{
	gnatmake -d "-P$@" -p
}

function FindTestHarness
{
	if [[ -f "./obj/gnattest/harness/test_driver.gpr" ]]; then
		echo $(pwd)/obj/gnattest/harness/test_driver.gpr
		return 0
	fi
	return 1
}

function GatherProjects
{
	oldIFS=$IFS
	IFS=$'\n'
	content=$(ls -1 --color=never)
	gpr_file=$(pwd)/$(echo $content | grep -o *.gpr)
	results=""


	if [[ -f "${gpr_file}" ]]; then
		test_driver=$(FindTestHarness)
		if [ $? -ne 0 ]; then
			echo "ERROR: Couldn't find test-driver for $gpr_file" >&2
			return 1
		fi
		results="$gpr_file"
		#echo $gpr_file
		#return 0
	fi

	for dir in $content
	do
		if [[ -d "$(pwd)/$dir" ]] && [ "$dir" != "gnattest" ]; then
			cd "${dir}"
			projects_gathered="$(GatherProjects)"
			if [ "$results" != "" ]; then
				results="$results"$'\n'
			fi
			results="$results$projects_gathered"

			cd ..
			if [ $? -eq 1 ]; then
				return 1
			fi
		fi
	done

	IFS=$oldIFS
	echo "$results"
	return 0
}
usage()
{
cat << EOF
usage: $0 -s SOURCE_FOLDER -o XML|GNATTest -d ON|OFF

SOURCE_FOLDER _must_ end with a trailing slash (/)

This script runs the build script.
Outputs either GNATTest report or XML reports.

OPTIONS:
    -h      Shows this message
    -o      Output format
    -d      Debug mode (default: off)
EOF
}

##########################################
# Entry point for script
##########################################
FORMAT=
DEBUG=

# Gathering input values. Some basics at the follwing page
# http://rsalveti.wordpress.com/2007/04/03/bash-parsing-arguments-with-getopts/
while getopts “hd:o:s:” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         o)
             FORMAT=$OPTARG
             ;;
         d)
             DEBUG=$OPTARG
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

# Checking if the input values are set
if [[ -z $FORMAT ]] || [[ -z $DEBUG ]]
then
     usage
     exit 1
fi

# Checking if the input values are set properly
if [[ $FORMAT != "XML" && $FORMAT != "GNATTest" ]]; then
     usage
     exit 1
fi

# Check #1: Current directory is "scripts"
# This script depends on that you run the script from its location.
if [[ $(basename $(pwd)) == "scripts" ]]; then
    # pass
    echo ""
else
    echo "You must run this script from the 'scripts' folder and the src folder"
    echo "must be located next to the scripts folder."
    exit 1
fi

# Check #2: "src" directory exists next to the "scripts" directory
dir=$(pwd)
parentdir="$(dirname "$dir")/src"
if [[ -d $parentdir ]]; then
    # pass
    echo ""
else
    echo "Source folder doesn't exist as sibling to the scripts folder."
    exit 1
fi

# Defining usable paths
# This script is assumed to be located in <project_root_dir>/scripts folder
script_file_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
root_dir="$(dirname $script_file_dir)"
source_dir="$root_dir/src"
tests_dir="$root_dir/tests"
build_dir="$root_dir/build"
main_path=$source_dir # Deprecated, old variable, removed when this is last reference.
xml_results_dir="$root_dir/xml_results"
build_logs_dir="$root_dir/build_logs"


##########################################
# Logging
##########################################
now=$(date +"%m_%d_%Y_%H_%M_%S")
if [[ ! -d "$build_logs_dir" ]]; then
    mkdir -pv $build_logs_dir
fi

# TODO: Piping STDOUT to build_log as well as showing on screen
# makes the script hang right before exit.
exec > >(tee "$build_logs_dir/build_$now.log")
exec 2>&1

# File decriptor for subshells
exec 5>&1

echo ""
echo "##########################################"
echo "# Logging started"
echo "# Logging to $build_logs_dir/build_$now.log..."
echo "#"
echo "# Gathering projects..."
echo "##########################################"
cd $source_dir
success=true
echo "INFO: SUCCESS variable set to $success (should be \"true\")"

projects=$(GatherProjects)
if [ $? -ne 0 ]; then
    echo "ERROR: Couldn't gather projects."
    echo ""
    exit 1
fi

# Clean up the print out.
projects=$(sed 's|.gpr |.gpr\n|g' <<< $projects)
echo ""
echo "#################################################"
echo "# Projects found that has a test harness set up"
echo "#################################################"
echo "$projects"
echo

echo ""
echo "#################################################"
echo "# Cleaning up from previous builds"
echo "#################################################"
cd $root_dir
if [[ -d "$tests_dir/" ]]; then
    if [[ $DEBUG == "ON" ]]; then
        echo "DEBUG: Removing previous tests [START]."
 	    rm -rfv "$tests_dir/"*
        echo "DEBUG: Removing previous tests [FINISHED]."
    else
        echo "INFO: Removing previous tests [START]."
 	    rm -rf "$tests_dir/"*
        echo "INFO: Removing previous tests [FINISHED]."
    fi
 	echo ""
fi

if [[ -d "$build_dir/" ]]; then
    if [[ $DEBUG == "ON" ]]; then
        echo "DEBUG: Removing previous build [START]."
	    rm -rfv "$build_dir/"*
        echo "DEBUG: Removing previous build [FINISHED]."
    else
        echo "INFO: Removing previous build [START]."
	    rm -rf "$build_dir/"*
        echo "INFO: Removing previous build [FINISHED]."
    fi
	echo ""
fi

if [[ -d "$xml_results_dir/" ]]; then
    if [[ $DEBUG == "ON" ]]; then
        echo "DEBUG: Removing previous xml_results [START]."
	    rm -rfv "$xml_results_dir/"*.xml
        echo "DEBUG: Removing previous xml_results [FINISHED]."
    else
        echo "INFO: Removing previous xml_results [START]."
	    rm -rf "$xml_results_dir/"*.xml
        echo "INFO: Removing previous xml_results [FINISHED]."
    fi
	echo ""
fi

echo ""
echo "#################################################"
echo "# Done cleaning"
echo "#"
echo "# Preparing to run tests"
echo "#################################################"

mkdir -pv $tests_dir
if [[ $DEBUG == "ON" ]]; then
    echo "DEBUG: Copying 'src' folder to 'tests' [START]."
    cp -rv $source_dir/* $tests_dir
    echo "DEBUG: Copying 'src' folder to 'tests' [FINISHED]."
else
    echo "INFO: Copying 'src' folder to 'tests' [START]."
    cp -r $source_dir/* $tests_dir
    echo "INFO: Copying 'src' folder to 'tests' [FINISHED]."
fi

echo ""
echo "#################################################"
echo "# Building and running all test harnesses"
echo "#################################################"

# echo ""
# build_project=$(pwd)
# echo ""
# echo $build_project
# build_project="${build_project##*/}"
# echo $build_project
# echo ""
failed_test_projects=
successful_test_projects=

echo ""
for project_path in $projects
do
 	# BASIC SET UP -------------------------------------------
    project_name="$(basename $project_path)"
 	project_name_wo_suffix="${project_name%.*}" # Remove filetype/suffix
 	test_path="$tests_dir/${project_path##*/src/}" # Remove test_dir+/src/ from project path

    unique_project_name=$(sed "s|$root_dir/src/||g" <<< $project_path)
 	unique_project_name="${unique_project_name%.*}" # Remove filetype/suffix
    unique_project_name=$(sed "s|/|-|g" <<< $unique_project_name)

    echo ""
    if [[ $DEBUG == "ON" ]]; then
        echo "DEBUG: Preparing tests for $project_path [START]."
        echo "DEBUG: project_name=$project_name"
        echo "DEBUG: test_path=$test_path"
    else
        echo "INFO: Preparing tests for $project_name [START]."
    fi

 	# CLEAN HARNESS -------------------------------------------
    if [[ $DEBUG == "ON" ]]; then
 	    echo "DEBUG: Cleaning test harness project for $project_path [START]."
    else
 	    echo "INFO: Cleaning test harness project for $project_name [START]."
    fi
    test_project=$(dirname $test_path)/obj/gnattest/harness/test_driver.gpr

    if [[ -f $test_project ]]; then
 	    gprclean -r "-P$test_project" -XRUNTIME=full
    fi

    if [[ $DEBUG == "ON" ]]; then
        echo "DEBUG: project_name=$project_name"
        echo "DEBUG: test_path=$test_path"
        echo "DEBUG: test_project=$test_project"
    fi

    if [[ $DEBUG == "ON" ]]; then
 	    echo "DEBUG: Cleaning test harness project for $project_path [FINISHED]."
    else
 	    echo "INFO: Cleaning test harness project for $project_name [FINISHED]."
    fi

 	# SET TEST REPORTER ---------------------------------------
     if [ $FORMAT == XML ]; then
        /bin/bash $root_dir/scripts/change_to_XML_reporter.sh -p $(dirname $test_project)

        if [[ $DEBUG == "ON" ]]; then
            echo "DEBUG: Setting Test Reporter to XML output."
        fi

     elif [ $FORMAT == GNATTest ]; then
         /bin/bash $root_dir/scripts/change_to_GNATTest_reporter.sh -p $(dirname $test_project)

        if [[ $DEBUG == "ON" ]]; then
            echo "DEBUG: Setting Test Reporter to GNATTest output."
        fi
     fi

    # BUILD TEST PROJECT ---------------------------------------
    if [[ $DEBUG == "ON" ]]; then
 	    echo "DEBUG: Building test harness project for $project_path [START]."
 	    echo "DEBUG: Building $test_project"
    else
 	    echo "INFO: Building test harness project for $project_name [START]."
    fi

 	build_success=true
    gnatmake -d -p "-P$test_project"
    if [ $? -ne 0 ]; then
        failed_test_projects="$failed_test_projects $project_path"
 	    build_success=false
 		all_projects_succeed=false
    else
        successful_test_projects="$successful_test_projects $project_path"
    fi

    if [[ $DEBUG == "ON" ]]; then
 	    echo "DEBUG: Building test harness project for $project_path [FINISHED]."
    else
 	    echo "INFO: Building test harness project for $project_name [FINISHED]."
    fi

    # PREPARATIONS COMPLETE ---------------------------------------
    if [[ $DEBUG == "ON" ]]; then
        echo "DEBUG: Preparing tests for $project_path [FINISHED]."
    else
        echo "INFO: Preparing tests for $project_name [FINISHED]."
    fi
    # RUN TEST PROJECT ---------------------------------------
    if [ $build_success == true ]; then
        if [[ $DEBUG == "ON" ]]; then
            echo "DEBUG: Running test project for $project_path [START]."
        else
            echo "INFO: Running test project for $project_name [START]."
        fi

            test_runner="${test_project%/*}/test_runner"
            if [ $FORMAT == XML ]; then
                mkdir -pv $root_dir/xml_results
                $("$test_runner" > $root_dir/xml_results/$unique_project_name.xml)

                echo "INFO: Exported results to $root_dir/xml_results/$unique_project_name.xml"

            elif [ $FORMAT == GNATTest ]; then
                echo "WARNING: Unimplemented, can't run tests with GNATTest reporter."
                echo "WARNING: Use '-o XML' instead."
            fi

        if [[ $DEBUG == "ON" ]]; then
            echo "DEBUG: Running test project for $project_path [FINISHED]."
        else
            echo "INFO: Running test project for $project_name [FINISHED]."
        fi
    else # Failed to build test harness project.
        if [[ $DEBUG == "ON" ]]; then
            echo "WARNING: Test project for $project_path failed to build."
            echo "WARNING: Not running tests for $project_path."
        else
            echo "WARNING: Test project for $project_name failed to build."
            echo "WARNING: Not running tests for $project_name."
        fi
    fi

    # END FOR CURRENT PROJECT ---------------------------------------
    if [[ $build_success == "true" ]]; then
        echo "INFO: Build [SUCCESSFUL]."
    else
        echo "INFO: Build [FAILED]."
    fi
    echo ""
done

# FINAL RESULTS OUTPUT FROM BUILD SCRIPT -------------------------------------
successful_test_projects=$(sed 's|.gpr |.gpr\n|g' <<< $successful_test_projects)
echo ""
echo "######################################################"
echo "# Projects with test harness that successfully build"
echo "######################################################"
echo "$successful_test_projects"

failed_test_projects=$(sed 's|.gpr |.gpr\n|g' <<< $failed_test_projects)
echo ""
echo "###################################################"
echo "# Projects with test harness that failed to build"
echo "###################################################"
echo "$failed_test_projects"


#
# 	mkdir -pv "$test_path/src"
# 	mkdir -pv "$test_path/obj/gnattest"
# 	cp -rv "$proj_path/src/"* "$test_path/src"
# 	cp -v "$proj" "$test_path"
# 	cp -rv "$proj_path/obj/gnattest/"* "$test_path/obj/gnattest"
# 	echo "...DONE"
# 	echo
	# ----------------------------------------
# 
# cp -rv "src/"* "tests"
# 
# for proj in $projects
# do
#     # Get project name
#     # TODO: This seems to be redundant moved from "run tests" part.
#     temp_path=${proj%/*}
#     project_name=${temp_path##*/}
# 
# 	# COPY PROJECT --------------------------------------------
# 	echo "Copying source for $proj..."
# 	proj_path="${proj%/*}"
# 	test_path="$(pwd)/tests/${proj_path##*$build_project/}"
# 	proj_name="${proj##*/}"
# 	proj_name="${proj_name%.*}"
# 
# # 	mkdir -pv "$test_path/src"
# # 	mkdir -pv "$test_path/obj/gnattest"
# # 	cp -rv "$proj_path/src/"* "$test_path/src"
# # 	cp -v "$proj" "$test_path"
# # 	cp -rv "$proj_path/obj/gnattest/"* "$test_path/obj/gnattest"
# # 	echo "...DONE"
# # 	echo
# 	# ---------------------------------------------------------
# 
# 	# CLEAN HARNESS -------------------------------------------
# 	echo "Cleaning harness for $proj..."
# 	test_project="$test_path/obj/gnattest/harness/test_driver.gpr"
# 	gprclean -r "-P$test_project" -XRUNTIME=full
# 	echo "...DONE"
# 	echo
# 	# ---------------------------------------------------------
# 
# 	# Set Test Reporter -----------------------------
#     # TODO: These scripts should take a path as input and run only for that
#     # input. Both scripts now parses all files in all projects on each run.
#     if [ $FORMAT == XML ]; then
#         echo "INFO: Setting Test Reporter to XML output."
#         /bin/bash $(pwd)/scripts/change_to_XML_reporter.sh
#         echo "INFO: Test Reporter set to XML output."
#     elif [ $FORMAT == GNATTest ]; then
#         echo "INFO: Setting Test Reporter to GNATTest output."
#         /bin/bash $(pwd)/scripts/change_to_GNATTest_reporter.sh
#         echo "INFO: Test Reporter set to GNATTest output."
#     fi
#     # ---------------------------------------------------------
# 
# 	# BUILD HARNESS -------------------------------------------
# 	echo "Building harness for $proj..."
# 	build_success=true
# 	gprbuild -d "-P$test_project" -XRUNTIME=full -p
# 	if [ $? -ne 0 ]; then
# 		build_success=false
# 		success=false
#         echo "INFO: SUCCESS variable set to \"$success\" (build harness failed)"
# 	fi
# 	echo "...DONE"
# 	echo
# 	# ---------------------------------------------------------
# 
# 	# RUN TESTS -----------------------------------------------
# 
# 	if [ $build_success == true ]; then
#         test_runner="${test_project%/*}/test_runner"
# 
# 		echo "INFO: Running tests for project \"$project_name\""
#         if [[ $DEBUG == "ON" ]]; then
#             echo "DEBUG: Running tests for project \"$proj\""
#         fi
# 
#         if [ $FORMAT == XML ]; then
# 
#             # Run test and output results as XML in project_root/xml_results
#             mkdir -pv $main_path../xml_results
#             $("$test_runner" > $main_path../xml_results/$project_name.xml)
# 
#             echo "INFO: Exported results to $main_path../xml_results/$project_name.xml"
# 
#         elif [ $FORMAT == GNATTest ]; then
#             test_result=$("$test_runner" --passed-tests=hide | tee >(cat - >&5))
# 
#             if [ "$(echo $test_result | grep -o FAILED)" == "FAILED" ]; then
#                 success=false
#                 if [[ $DEBUG == "ON" ]]; then
#                     echo "DEBUG: Project \"$proj_name\" had a test that failed."
#                 fi
#             elif [ "$(echo $test_result | grep -o CRASHED)" == "CRASHED" ]; then
#                 if [[ $DEBUG == "ON" ]]; then
#                     echo "DEBUG: Project \"$proj_name\" had a test that crashed."
#                 fi
#                 success=false
#             fi
#         fi
# 		echo "INFO: Test run for project \"$project_name\" finished."
# 		echo
# 	fi
# 	# ---------------------------------------------------------
# done
# 
# if [ $success == false ]; then
# 	echo "ERROR: One or more tests failed/crashed."
# 	echo
# 	exit 1
# fi
# 
# for proj in $projects
# do
# 	echo "Building project $proj..."
# 	proj_path="${proj%/*}"
# 	build_path="$(pwd)/build/${proj_path##*$build_project/}"
# 	test_path="$(pwd)/tests/${proj_path##*$build_project/}"
# 	proj_name="${proj##*/}"
# 
# 	mkdir -pv $build_path
# 
# 	
# 	gnatmake -d "-P$test_path/$proj_name"
# 	cp -v "$test_path/obj/"* "$build_path" 2>/dev/null
# 
# 	echo "...DONE"
# 	echo
# done
# 
if $all_projects_succeed == true; then
    echo ""
    echo "##############################################################"
    echo "# [$(date +%Y-%m-%d) $(date +%H:%M:%S)] Build [SUCCESSFUL]."
    echo "# End of build script"
    echo "##############################################################"
    exit 0
else
    echo ""
    echo "##############################################################"
    echo "# [$(date +%Y-%m-%d) $(date +%H:%M:%S)] Build [FAILED]."
    echo "# End of build script"
    echo "##############################################################"
    exit 1
fi
