# File Paths in R

## What is a File Path? 
A file path is the location of a file or folder on a computer.

Example:
```text
Documents/R-Projects/MyProject/data/data.csv
```

## 1. Absolute Path
An absolute path is the complete location of a file, starting from the root of the computer. It tells R the exact location of the file.

Example: 
```text
read.csv("/Users/username/Documents/R-Projects/MyProject/data/data.csv")
```
Key idea: Absolute path = WHERE IS THE HOUSE? (It is like giving the **full address of your house)

## 2. Relative Path
A relative path describes the location of a file relative to the current working directory or R Project.

Example

If the project structure is:
MyProject/
├── MyProject.Rproj
├── data/
│   └── data.csv
└── scripts/
    └── analysis.R

The relative path to the dataset is:
```text
read.csv("data/data.csv")
```
Key idea: Relative path = WHERE TO GO FROM HERE? (You don't need to give the full house address. You only need to give the direction from where you are.)

## 3. Working Directory
The working directory is the folder that R currently uses as its starting point when looking for files.

```text
getwd()
```
Key idea: Working directory = WHERE ARE YOU NOW? (You are already inside your house. Someone asks:Where are you now?Your answer: I'm at home)
