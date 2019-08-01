#!/bin/bash

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

# Not sure how to get find tot ignore .git while maintaining the same functionality, so moving it outside and then back after script is done
IGN_FOLDER_LIST='.git .circleci'
dir=$(pwd)
if [ $USE_LTMK -eq 1 ]
then
  for d in $(find $dir -maxdepth 4 -type d)
  do
      curr_dir=$(basename $d)
      echo $curr_dir
      if [[ " $IGN_FOLDER_LIST " =~ .*\ $d\ .* ]]; then
        echo "Not processing this folder, no tex files"
        echo $d
      else
        echo $d
        cd $d
        latexmk -pdflatex=lualatex -pdf
        cd $dir
      fi
  done
fi

if [ $M_PDF2PNG != 2 ]
then
  for pdf in $(find $dir -name "*.pdf")
  do
    # echo $tex
    cur_dir=$(dirname $pdf)
    # Go to directory with pdf files
    cd $cur_dir
    new_name=$(basename "$pdf" | cut -d. -f1)
    new_image=$(echo "$new_name.png")
    if [ $M_PDF2PNG -eq 0 ]
    then
      if [ -f "./$new_image" ]; then
          echo "$new_image exists skipping file."
      else 
          echo "$new_image does not exist, converting pdf to png."
          magick convert -density 300 -depth 8 -quality 150 $pdf $new_image
      fi
    else
      pdftopng -png $pdf $new_name
    fi
    # Go back to root directory
    cd $dir
  done
fi

if [ $GEN_README == 1 ]
then
  # Make new markdown file every run 
  rm $OUTPUT_FILE
  echo "## Latex Diagrams" >> $OUTPUT_FILE

  echo "This repo contains all the diagrams I have generated for my academic career at the University Of Victoria." >> $OUTPUT_FILE
  echo "" >> $OUTPUT_FILE

  echo "" >> $OUTPUT_FILE
  cat "ReadMeToc.md" >> $OUTPUT_FILE
  echo "" >> $OUTPUT_FILE

  echo "" >> $OUTPUT_FILE
  # Generate markdown file containing relative url to image and perhgaps path to tex code.
  prev_dir=''
  for tex in $(find $dir -name "*.tex")
  do
    cur_dir=$(dirname $tex)
    rel_folder_path=$(realpath --relative-to="$dir" "$cur_dir")
    rel_path_file=$(realpath --relative-to="$dir" "$tex")
    
    if [ "$prev_dir" != "$rel_folder_path" ]
    then
      prev_dir=$rel_folder_path
      echo "### $rel_folder_path" >> $OUTPUT_FILE
      echo "" >> $OUTPUT_FILE
    else
      echo "Parsing $rel_path_file from $rel_folder_path"
    fi
    ### Add diagram to markdown file 
    # ![Alt text](/relative/path/to/img.jpg?raw=true "Optional Title")
    # Replace tex extension with png
    rel_image_path=$(basename "$rel_path_file" | cut -d. -f1)
    echo "![$rel_folder_path]($rel_folder_path/$rel_image_path.png?raw=true \""$rel_image_path"\")" >> $OUTPUT_FILE
    echo "" >> $OUTPUT_FILE
    ### Add code to markdown file
    echo "\`\`\`tex" >> $OUTPUT_FILE
    cat $rel_path_file >> $OUTPUT_FILE
    echo "" >> $OUTPUT_FILE
    echo "\`\`\`" >> $OUTPUT_FILE
    echo "" >> $OUTPUT_FILE
    # Go to directory with pdf files
    # Go back to root directory
    # cd $dir
  done
fi

mv ../.git . || true
