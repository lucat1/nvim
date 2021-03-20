#!/bin/bash

root=$1
dir=$2
url=$3
echo "root: $root"
echo "dir: $dir"
echo "url: $url"

rel=${dir#$root}
urel=$url$rel
out="${dir}index.html"
echo "rel: $rel"
echo "urel: $urel"
echo "out: $out"

cat << EOF > $out
<html>
<head><title>Index of /</title></head>
<body>
<h1>Index of $rel</h1>
EOF
if [ "$rel" == "/" ]; then
  echo "<hr><pre><a href="$urel">../</a>" >> $out
else
  echo "<hr><pre><a href="$url$(dirname $rel)">../</a>" >> $out
fi

# <a href="current/">current/</a>                                           20-Mar-2021 14:06                   -
# <a href="distfiles/">distfiles/</a>                                         01-Jan-2021 15:47                   -
# <a href="docs/">docs/</a>                                              20-Mar-2021 14:00                   -
# <a href="live/">live/</a>                                              16-Mar-2021 23:36                   -
# <a href="logos/">logos/</a>                                             14-Mar-2021 23:08                   -
# <a href="static/">static/</a>                                            13-Mar-2020 00:25                   -
# <a href="void-updates/">void-updates/</a>                                      20-Mar-2021 04:11                   -
# <a href="xlocate/">xlocate/</a>                                           20-Mar-2021 06:01                   -

for f in $dir/*;do
  file=$(basename $f)
  if [ "$file" == "index.html" ]; then
      echo "ignored: $file"
      continue
  fi

  size=$(du -s $f | awk '{print $1;}')
  s=$(stat -c %y $f)
  stat=${s%%.*}
  if [ -f "$f" ]; then
    printf '<a href="%s%s">%-40s%35s%20s\n' "$urel" "$file" "$file</a>" "$stat" "$size" >> $out
  elif [ -d "$f" ]; then
    echo "---------- recursive ----------"
    bash $0 $root $dir$file/ $url
    echo "---------- recursive ----------"
    printf '<a href="%s%s">%-40s%35s%20s\n' "$urel" "$file/" "$file/</a>" "$stat" "-" >> $out
  fi
done

cat << EOF >> $out
</pre><hr></body>
</html>
EOF
