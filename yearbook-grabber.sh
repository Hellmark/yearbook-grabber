#!/usr/bin/env bash
set -euo pipefail

numpage=${1}
numdigits=${3}
output_dir=${2}
base_url=${3}

if [[ -z "$numpage" ]]; then
  echo "Usage: $0 <number_of_images> <minimum number of digits for padding> <output_directory> <base_url>"
  exit 1
fi

if [[ -z "$numdigits" ]]; then
  echo "Usage: $0 <number_of_images> <minimum number of digits for padding> <output_directory> <base_url>"
  exit 1
fi

if [[ -z "$output_dir" ]]; then
  echo "Usage: $0 <number_of_images> <minimum number of digits for padding> <output_directory> <base_url>"
  exit 1
fi

if [[ -z "$base_url" ]]; then
  echo "Usage: $0 <number_of_images> <minimum number of digits for padding> <output_directory> <base_url>"
  exit 1
fi

#example of where nabbed from: https://www.classmates.com/yearbooks/school/ritenour-high-school/1622?decade=2000

mkdir -p "$output_dir"

printf "Downloading images 0001 through %0${numdigits}d to %s\n" "$numpage" "$output_dir"

for i in $(seq -f "%0${numdigits}g" 1 "$numpage"); do
  filename="${i}.jpg"
  url="${base_url}/${filename}"
  out="$output_dir/$filename"

  if [[ -f "$out" ]]; then
    printf "skipping existing %s\n" "$out"
    continue
  fi

  wget -P "$output_dir" -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" "$url" 
  printf "$url\n"
  printf "downloaded %s\n" "$out"
done
