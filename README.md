# Stowaway

Stowaway is a gem that searches a web project for files that aren't being used.  By default it will search in the directory of your choice for files that have the following extension:

 * .jpg 
 * .gif 
 * .png 
 * .ico
 * .js
 * .css

## Installing

    sudo gem install ecavazos-stowaway
    
## Note

I'll be adding support for matching on relative and absolute paths.  Currently, only file names are being checked for matches.  If you have two files with the same name but they reside in different directories, they will be treated as one.  Comparing by path will preserve the uniqueness of the file.