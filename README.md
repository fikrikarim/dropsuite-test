# Hello Dropsuite!

## About

A simple ruby program to search a directory to find file with largest number of duplicates. The program will return the content of the file and the total number of duplicates.

## How to run

1. Clone the repo
2. Change directory to repo directory
3. Run `ruby app.rb`

## Options

1. Pass an argument select which directory to search.
Ex: `ruby app.rb ~/downloads`. Search current directory as default.

## How it works

The program searches the directory recursively and stores files with the same filesize. Then it compares the MD5 of the files to ensure the content is identical.

## Benchmarking

Using MBP "13 2015 and my files, using `Benchmark.realtime`

| Directory     | File numbers  | Directory size (GB) | Execution time (s)  |
| ~/downloads   | 7209          | 6,13                | ~0.1                |
| ~/workspace   | 103942        | 1,16                | ~1.8                |


## Limitations

1. MD5 is known as not a so secure hash. So some not identical files can have the same MD5 and be detected as identical by this program.

## Further improvements

1. Add an option to use other more secure hash like SHA-256. To avoid uniqueness collision
2. Check for file type, and the first and last range of bytes before checking the hashes.
3. Add automated test suite


This app is inspired by this [SO answer](https://stackoverflow.com/questions/9808156/detecting-duplicate-files/9808270#9808270)