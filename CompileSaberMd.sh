#!/bin/bash

# Compiles individual latex diagrams into individual markdown files
# To be served with saber

function usage {
  echo -e "\033[0;35mIll-formed arguments. Use the following format.\033[0m"
  echo "Usage: $0 [-r <int>] [-p <int>] [-l <int>] [-o <string>]"
  echo "-r Create a markdown file with tex source. 1 for yes, 0 for no. Default=1"
  echo "-p Method that to convert pdf to png. 0= Imagemagick, 1=pdftopng. Default = 0"
  echo "-l Use latexmk to compile documents. 1 for yes, 0 for no. Default=1"
  echo "-o Output File for Markdown documentation of tex files. Default=ReadMe.md"
  exit 1
}

# Defaults
GEN_README=1
M_PDF2PNG=0
USE_LTMK=1
OUTPUT_FILE="ReadMe.md"

# Get options
while getopts ":r:p:l:o:" o; do
  case "${o}" in
    r)
      GEN_README=${OPTARG}
      ;;
    p)
      M_PDF2PNG=${OPTARG}
      ;;
    l)
      USE_LTMK=${OPTARG}
      ;;
    o)
      OUTPUT_FILE=${OPTARG}
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

# Validate options
# testing for empty strings, and ensuring numbers are within max ranges
if [[ "$GEN_README" > 1 || "$M_PDF2PNG" > 2 || "$USE_LTMK" > 1 ]]; then
  usage
fi

dir=$(pwd)
# For now just copy pages over
if [ $GEN_README == 1 ]
then
  # index page made manually
  OUTPUT_DIR="saber"
  IMAGE_DIR="$OUTPUT_DIR/static"
  MD_DIR="$OUTPUT_DIR/pages"
  # Remove pages directory, recreate every time
  rm -rf $OUTPUT_DIR
  # Make new markdown file every run 
  mkdir -vp $OUTPUT_DIR
  prev_dir=''
  # Generate markdown file containing relative url to image and perhaps path to tex code.
  for tex in $(find $dir -name "*.tex")
  do
    cur_dir=$(dirname $tex)
    rel_folder_path=$(realpath --relative-to="$dir" "$cur_dir")
    rel_path_file=$(realpath --relative-to="$dir" "$tex")
    
    if [ "$prev_dir" != "$rel_folder_path" ]
    then
      prev_dir=$rel_folder_path
    else
      echo "Parsing $rel_path_file from $rel_folder_path"
    fi
    # make markdown file
    rel_image_path=$(basename "$rel_path_file" | cut -d. -f1)
    # copy image files to new folder
    mkdir -vp $MD_DIR/$rel_folder_path
    mkdir -vp $IMAGE_DIR/$rel_folder_path

    single_file_output=$MD_DIR/$rel_folder_path/$rel_image_path.md
    image_file="$(basename -- $rel_folder_path/$rel_image_path.png)"
    cp $rel_folder_path/$rel_image_path.png $IMAGE_DIR/$rel_folder_path/$rel_image_path.png 

    # Yaml header, saber throws errrors without one of these in the md files
    echo "---" >> $single_file_output
    echo "title: $image_file" >> $single_file_output
    cur_date=$(date +%s)
    DATE_HREAD=$(date -d @$cur_date +"%Y-%m-%d %H:%M:%S")
    echo "date: $DATE_HREAD" >> $single_file_output
    echo "layout: plain" >> $single_file_output
    # temp copy of file
    # Copy first 20 lines 
    TEMPFILE="temp.file"
    SMALLFILE="parse.file"
    head -10 $tex >> $TEMPFILE 
    tr -d '\n' < "temp.file" >> $SMALLFILE
    words=$(grep -o -E '\w+' "temp.file" | sort -u -f)
    stripped_words=$(printf '%s' "$words" | sed 's/[0-9]//g')
    purged_words=$(printf '%s' "$stripped_words" | sed  's/em//g; s/pt/ab/g; s///g; s/documentclass//g; 
      s/usepackage//g; s/usetikzlibrary//g; s/and//g;')
    long_words=$(printf '%s' "$purged_words" | sed -E 's/\b\w{1,3}\b//g')
    rm $TEMPFILE
    rm $SMALLFILE
    echo "---" >> $single_file_output

    echo "### Keywords" >> $single_file_output
    echo "$long_words" | tr "\n" " " >>  $single_file_output 
    echo "" >>  $single_file_output
    echo "![$rel_folder_path]($image_file \""$rel_image_path"\")" >> $single_file_output 
    echo "" >> $single_file_output
    ### Add code to markdown file
    echo "\`\`\`tex" >> $single_file_output
    cat $rel_path_file >> $single_file_output
    echo "" >> $single_file_output
    echo "\`\`\`" >> $single_file_output
    echo "" >> $single_file_output
    # Go to directory with pdf files
    # Go back to root directory
    # cd $dir
  done
fi
