
download_royalties <- function(){

  ## scrapper
  url <- "https://www.gov.br/anp/pt-br/centrais-de-conteudo/dados-abertos/participacoes-governamentais"
  links <- url %>%
    read_html() %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    as.list() %>%
    str_subset("royalties-municipios")

  ## baixando os .csv

  links <- as.list(links)
  dest <- as.character(2019:2009)
  dest <- glue::glue("data/municipios-{dest}.csv")

  walk2(links, dest, download.file, mode = "wb")

  #teste







}
