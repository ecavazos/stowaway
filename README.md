# Stowaway

Stowaway will search through the source code of a web project and find all
of the images, scripts and stylesheets that aren't being used.  To use,
simply provide the path to the directory you wish to search.  

*Please read the _warning_ section at the end before using*

## Example
    stowaway ~/repos/rails/my_rails_app/

Stowaway, by default, will search for the most common file types. Using the
_-t_ flag, you can tell stowaway to use custom file types.

## Default Types

 * .jpg
 * .gif
 * .png
 * .ico
 * .js
 * .css

## Installing

    sudo gem install stowaway

## Matching

Stowaway assumes the path you provide is the root for your web application
and will have no problem matching root-relative links to the actual files.

The example below will result in a positive match:

    # path to file: /my_app/images/foo.jpg
    # image tag: <img src="/images/foo.jpg" />

Stowaway currently recognizes the following as valid references:

    src="/file.jpg"
    href="/file.jpg"
    :src => "file.jpg"
    :href => "file.jpg"
    = javascript_include_tag "file"
    = javascript_include_tag "file.js"
    = javascript_include_tag "file.js", "foo/bar.js"
    = stylesheet_link_tag "file"
    = stylesheet_link_tag "file.css"
    = stylesheet_link_tag "file.css", "foo/bar.css"
    url("/file.jpg")

## Partial Matching

As a fall back, stowaway will match on file name.  It will
report the number of files that were matched by name only at the end of a run.

## Usages

    # basic usage
    stowaway path/to/site

    # from directory
    stowaway .

    # with file types
    stowaway -t .js .css path/to/site

## Warning

Stowaway is useful for maintaining a tidy source tree, but it's not perfect.
I probably don't need to say this, but a good VCS is mandatory.  So before you
start deleting files, make sure all your awesome changes have been committed and
that you double-check stowaway's result against your own manual process.
