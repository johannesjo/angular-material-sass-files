#!/usr/bin/env bash
rm -rf *.scss ./components ./themes ./.tmp
git clone git@github.com:angular/material.git .tmp/material
mkdir .tmp/scss
mkdir .tmp/scss/themes
mkdir .tmp/scss/components
find .tmp/material -name "*.scss" -exec cp {} .tmp/scss/ \;
rm .tmp/scss/_name_.scss
rm .tmp/scss/_name_-theme.scss
cd .tmp/scss
for filename in *.scss; do mv "$filename" "_$filename"; done;
for filename in *-theme.scss; do mv "$filename" "themes/$filename"; done;
for filename in *.scss; do mv "$filename" "components/$filename"; done;
mv components/_variables.scss _variables.scss
mv components/_mixins.scss _mixins.scss
mv components/_style.scss _style.scss

mainFile="angular-material.scss"

# check if mainFile exists. this is not required as echo >> would
# would create it any way. but for this example I've added it for you
# -f checks if a mainFile exists. The ! operator negates the result
if [ ! -f "$mainFile" ] ; then
    # if not create the mainFile
    touch "$mainFile"
fi

find . -name "*.scss" |
    while IFS= read -r line
        do
            echo "@import \"$line\";" >> "$mainFile"
        done

mv * ../../