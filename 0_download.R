library(magrittr)

load("data-raw/ibge_tse.Rda")

uf_total <- ibge_tse %>% with(uf) %>% unique()


urlbase <- "https://resultados.tse.jus.br/oficial/ele2020/divulgacao/oficial/426/dados-simplificados/"


download_pref_uf_mun <- function(mun, uf, url, verbose = FALSE) {
  if (verbose) {
    cat(paste0("UF: ", stringr::str_to_upper(uf), "\tMun: ", mun, "\n"))
  }
  url <- paste0(url, uf, "/", uf, mun, "-c0011-e000426-r.json")
  req <- httr::GET(url)
  if (req$status_code == 200) {
    if (verbose) {cat ("status 200!\n")}
    j <-  req %>%
      httr::content(as = "text", encoding = "UTF-8") %>%
      jsonlite::fromJSON()
    turno <- j$t
    tf <- j$tf
    cand <- j %>%
      purrr::pluck("cand") %>%
      tibble::as_tibble() %>%
      dplyr::mutate(turno = turno, totalizacao_final = tf)
  } else {
    if (verbose) {cat("request fail :(\n")}
    tibble::tibble()
  }
}

download_pref_uf <- function(estado, url, verbose = FALSE, path) {
  dir.create(path, showWarnings = FALSE)
  cod <- ibge_tse %>%
    dplyr::filter(uf == estado) %>%
    with(cod_tse_5)
  estado <- stringr::str_to_lower(estado)
  cand <- purrr::map_df(cod, download_pref_uf_mun, uf = estado, url = url, verbose = verbose) %>%
    dplyr::mutate(uf = estado)
  path <- paste0(path, "/pref_", estado, ".csv")
  readr::write_csv(cand, path)
}

# teste <- download_pref_uf("RO", urlbase, verbose = TRUE, path = "csv")


# Baixar todos os estados em CSV ------------------------------------------

uf_total %>%
  purrr::map(download_pref_uf, url = urlbase, path = "csv")


