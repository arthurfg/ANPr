
download_royalties <- function(ano_inicial, ano_final){
  '%>%' <- magrittr::`%>%`

  ## scrapper
  url <- "https://www.gov.br/anp/pt-br/centrais-de-conteudo/dados-abertos/participacoes-governamentais"
  pattern <- c("royalties-municipios", "royalties-municipio-2020")
  anos_vetor <- (ano_final:ano_inicial)

  links <- url %>%
    xml2::read_html() %>%
    rvest::html_nodes("a") %>%
    rvest::html_attr("href") %>%
    as.list() %>%
    stringr::str_subset(paste(pattern, collapse = "|")) %>%
    stringr::str_subset(paste(anos_vetor, collapse = "|"))



  ## baixando os .csv

  links <- as.list(links)
  dest <- as.character(ano_final:ano_inicial)
  wd <- getwd()
  dest <- glue::glue("{wd}/municipios-{dest}.csv")

  purrr::walk2(links, dest, utils::download.file, mode = "wb")


  #teste

  municipios_2019 %>%
    dplyr::filter(municipio == "macae") %>%
    dplyr::mutate(competencia = openxlsx::convertToDate(competencia),
                  caixa =  openxlsx::convertToDate(caixa))





}

