Generate passwords, password hashes, typewriter words, and fake words!

## autotypewrite
This script is the improved version of the `typewriting` script and:
- Intakes a dictionary file (or by default uses the large_dictionary.txt in the dictionary_files directory)
- Outputs a list of words that are typed with alternating hands on a QWERTY keyboard

This can optionally take a "-b" option to use the bad_words.txt dictionary file to filter out bad words.

## genfakewords
This script is intended to allow you to generate your own dictionary file of "fake" words. It intakes a real dictionary file and learns what words in that dictionary "look like," then pieces together words that fit your parameters

```
Usage: ./genfakewords [-#] [-m min] [-M max] [-i input] [-o output] [-s]

All flags are optional.

Options:
  -#       The number of fake words to generate (e.g., -1000 for 1000 words). Default is 25.
  -m       Minimum character length for generated words. Default is 5.
  -M       Maximum character length (clips the final string). Default is 10.
  -i       Path to the input dictionary file for the script to learn from. Default is ../dictionary_files/large_dictionary.txt.
  -o       Direct output to a specific file. Outputs to stdout by default.
  -s       Print a representation of the character-pair hash and exit.

Example:
  ./genfakewords -1000 -m 12 -M 20 -i my_words.txt -o new_dict.txt
```

## passwordgen.sh
This script is intended to turn words from a dictionary file into more secure passwords, using the autotypewrite script to filter for fast-to-type words. To really get the most from this, use genfakewords to generate a dictionary file of fake words and use that for this script. All arguments are optional, and defaults to the large_dictionary.txt dictionary file.

Takes two arguments: an output count and a dictionary file

Example: ./passwordgen.sh 12 dictionary.txt
