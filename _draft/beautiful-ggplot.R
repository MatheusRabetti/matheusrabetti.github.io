# Candidates files
tf <- tempfile(); td <- tempdir()
for(ano in seq(2000,2016, 4)){
  cat('Downloading year', ano)
  url = paste0('http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_cand/consulta_cand_',
               ano,'.zip')
  download.file(url = url, destfile = tf)
  unzip(tf, exdir = td)
}

# The files are

# BASH
# > cd ../../temp/Rtmp5DZdeI
# > wc -c consulta_cand_2000_SP.txt
# 30386241 consulta_cand_2000_SP.txt
# 30 Mb

# head -n 3 consulta_cand_2000_SP.txt
# head -n 3 consulta_cand_2016_SP.txt | iconv -f iso-8859-1 -t UTF-8
# Separator = ;
# Encoding = iso-885901 | latin-1
# Nulo = '#NULO#'
# HEADER = F


# Percentage of women as candidates
# Beautiful ggplot
getwd()
readLines('/tmp/Rtmp5DZdeI/')
