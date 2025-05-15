# Generate article PDFs with maybe wrong page numbers
for folder in $( ls -d -1 ../interviews/* ../essays/* ../papers/* ); do
 cd $folder
 myst build --pdf
 cd ../../scripts
done
# Update page numbers in article myst.ymls
bash ./update_pages.sh 5 ../interviews/* ../essays/* ../papers/*
# Re-generate PDFs with correct page numbers
for folder in $( ls -d -1 ../interviews/* ../essays/* ../papers/* ); do
 cd $folder
 myst build --pdf
 cd ../../scripts
done
# Write frontmatter page number summary
bash ./generate_summary.sh ../templates/ncssm-preface/papers.yml ../interviews/* ../essays/* ../papers/*
# Generate frontmatter PDF
cd ../frontmatter
myst build --pdf
cd ../
# Combine all PDFs into final PDF
pdftk frontmatter/article.pdf interviews/*/article.pdf essays/*/article.pdf papers/*/article.pdf cat output morganton2025.pdf
