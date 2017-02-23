for $b in doc("books.xml")/bookstore/book
return if ($b/@category="children")
then <child>{data($b/title)}</child>
else <adult>{data($b/title)}</adult>
