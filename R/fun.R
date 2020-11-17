#' Download dados por município
#'
#' @param mun código de município do TSE, ver [ibge_tse]
#' @param uf sigla UF
#' @param cargo cargo pretendido c("prefeito", "vereador")
#' @param verbose TRUE para ver municípios baixados
#'
#' @return tabela com dados de votação do município
#'
download_uf_mun <- function(mun, uf, cargo = "prefeito", verbose = FALSE) {
  url <- "https://resultados.tse.jus.br/oficial/ele2020/divulgacao/oficial/426/dados-simplificados/"
  if (verbose == TRUE) {
    cat(paste0("UF: ", toupper(uf), "\tMun: ", mun, "\n"))
  }

  cargo <- tolower(cargo)
  if (cargo == "prefeito") {
    url <- paste0(url, uf, "/", uf, mun, "-c0011-e000426-r.json")
  }
  if (cargo == "vereador") {
    url <- paste0(url, uf, "/", uf, mun, "-c0013-e000426-r.json")
  }

  req <- httr::GET(url)
  if (req$status_code == 200) {
    if (verbose) {cat ("status 200!\n")}
    j <-  req %>%
      httr::content(as = "text", encoding = "UTF-8") %>%
      jsonlite::fromJSON()
    cand <- j %>% dplyr::as_tibble()
    aux <- cand %>% with(cand) %>%
      stats::setNames(paste0("cand_", names(.)))
    cand <- cand %>%
      stats::setNames(paste0("raiz_", names(.))) %>%
      dplyr::select(-raiz_cand) %>%
      dplyr::bind_cols((aux))

  } else {
    if (verbose) {cat("request fail :(\n")}
    dplyr::tibble()
  }
}

#' Download dados por UF
#'
#' @param estado sigla UF
#' @param cargo cargo pretendido c("prefeito", "vereador")
#' @param verbose TRUE para ver municípios baixados
#'
#' @return baixa arquivos em CSV
#'
download_uf_ <- function(estado, cargo, verbose = FALSE) {
  cod <- ibge_tse %>%
    dplyr::filter(uf == estado) %>%
    with(cod_tse_5)
  estado <- tolower(estado)
  cand <- purrr::map_df(cod, download_uf_mun, uf = estado, verbose = verbose) %>%
    dplyr::mutate(uf = toupper(estado), cargo_pretendido = toupper(cargo)) %>%
    dplyr::mutate(dplyr::across(.fns = stringr::str_squish))

  if (verbose == TRUE) {
    cat(paste0("Arquivo salvo em ", path))
  }
  return(cand)
}

#' Download dados por UF
#'
#' @param estado sigla UF (ou "todos")
#' @param cargo cargo pretendido c("prefeito", "vereador")
#' @param verbose TRUE para ver municípios baixados
#' @param path pasta onde salvar os arquivos CSV
#'
#' @return baixa arquivos em CSV
#'
#' @export
#'
download_uf <- function(estado, cargo, path = NULL, verbose = FALSE) {

  if(estado == "todos") {
    t <- ibge_tse %>%
      with(uf) %>%
      unique() %>%
      purrr::map(download_uf_, cargo)
  } else {
    t <- download_uf_(estado, cargo)
  }

  if(!is.null(path)) {
    dir.create(path, showWarnings = FALSE)
    path <- paste0(path, "/", cargo, "_", estado, ".csv") %>%
      gsub("//", "/", .)
    readr::write_csv(t, path)
  }
  return(t)
}




#' Códigos de municípios
#'
#' Códigos de municípios brasileiros utilizados pelo IBGE e TSE
#'
#' @format Tabela com 6 colunas e 5570 linhas:
#' \describe{
#'   \item{uf}{UF}
#'   \item{cod_uf_ibge}{cod_uf_ibge}
#'   \item{cod_ibge_5}{cod_ibge_5}
#'   \item{cod_ibge_7}{cod_ibge_7}
#'   \item{cod_tse_5}{situação cod_tse_5}
#'   \item{municipio}{municipio}
#' }
#'
#' @name ibge_tse
"ibge_tse"

utils::data("ibge_tse", package = "eleicoesmun2020", envir = environment())
