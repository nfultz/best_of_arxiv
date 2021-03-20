
sed '/<script[^>]*>/,/<\/script>/d' all.html > all3.html
cat <<EOF >>all3.html
<script>
content = Array.from(document.querySelectorAll("div.post"))
document.body.innerHTML=""

content.sort((x,y) =>   (new Date(x.children[1].innerText.replace(/ by.*/, "")) > new Date(y.children[1].innerText.replace(/ by.*/, "")  ) ) ? 1 : -1)

content.forEach(x => document.body.appendChild(x))


Array.from(document.querySelectorAll("div.post div.shariff")).map(x => x.parentNode.removeChild(x))
Array.from(document.querySelectorAll("div.entry-content ~ div")).map(x => x.parentNode.removeChild(x))
Array.from(document.querySelectorAll("div.post> div.entry-content p")).filter(x => x.textContent.startsWith("In this recurring")).map(x => x.parentNode.removeChild(x))
</script>
EOF

google-chrome --user-data-dir=$(mktemp -d) --headless --dump-dom all3.html >best_of.html
rm all3.html

