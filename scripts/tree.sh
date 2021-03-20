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
