go mod graph | sed -Ee 's/@[^[:blank:]]+//g' | sort | uniq >>unver.txt

echo "digraph {
    graph [overlap=false, size=14]; root=\"$(go list -m)\";
    node [ shape = plaintext, fontname = \"Helvetica\", fontsize=24]; 
    \"$(go list -m)\" [style = filled, fillcolor = \"#E94762\"];" >>graph.dot

cat unver.txt | awk '{print "\""$1"\" -> \""$2"\""};' >>graph.dot
echo "}" >>graph.dot

sed -i '' 's+\("github.com/[^/]*/\)\([^"]*"\)+\1\\n\2+g' graph.dot

sfdp -Tsvg -o graph.svg graph.dot