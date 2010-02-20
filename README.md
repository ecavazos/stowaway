# Stowaway

Stowaway will search through the source code of a web project and find all
of the images, scripts or stylesheets that aren't being used.  To use,
simply provide the path to the directory you wish to search.

## Example
    stowaway ~/repos/rails/my_rails_app/

Stowaway, by default, will search for the most common file types.

## Default Types

 * .jpg .gif .png .ico
 * .js
 * .css

## Installing

    sudo gem install stowaway

## Matching

Stowaway assumes the path you provide is the root for your web application
and will have no problem matching root-relative links to the actual files.
Consider the example below:

    # path to file: /my_app/images/foo.jpg
    # image tag: <img src="/images/foo.jpg" />

## Usages

    # basic usage
    stowaway path/to/site

    # from directory
    stowaway .

    # with file types
    stowaway -t .js .css path/to/site

## Note

I'll be adding support for matching on relative and absolute paths (Comparing by 
path will preserve the uniqueness of the file).  Currently, only file names are 
being checked for matches.  If you have two files with the same name but they 
reside in different directories, they will be treated as one.  In other words, 
if you have multiple files with the *same name*, stowaway won't work right.  

