#' Download dados por município
#'
#' @param mun código de município do TSE, ver [ibge_tse]
#' @param uf sigla UF
#' @param cargo cargo pretendido c("prefeito", "vereador")
#' @param turno turno (1 ou)
#' @param verbose TRUE para ver municípios baixados
#'
#' @return tabela com dados de votação do município
#'
download_uf_mun <- function(mun, uf, cargo, turno, verbose = FALSE) {

  url <- "https://resultados.tse.jus.br/oficial/ele2020/divulgacao/oficial/"

  if (turno == 1) {
    url <- paste0(url, "426/dados-simplificados/")
  }
  if (turno == 2) {
    url <- paste0(url, "427/dados-simplificados/")
  }

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
    aux <- cand %>% with(cand)
    if (length(aux) > 0) {
      aux <- aux %>%
        dplyr::mutate(dplyr::across(.fns = as.character)) %>%
        dplyr::rename_with(~paste0("cand_", .), .cols = dplyr::everything())
      cand <- cand %>%
        dplyr::select(-cand) %>%
        dplyr::mutate(dplyr::across(.fns = as.character))
    } else {
      cand <- j %>% purrr::map(purrr::pluck) %>% unlist()
      cand <- cand %>%
        dplyr::as_tibble() %>%
        dplyr::mutate(name = names(cand)) %>%
        tidyr::pivot_wider() %>%
        dplyr::mutate(dplyr::across(.fns = as.character))
      aux <- dplyr::tibble(
        'seq' = NA_character_, 'sqcand' = NA_character_, 'n' = NA_character_, 'nm' = NA_character_, 'cc' = NA_character_, 'nv' = NA_character_, 'e' = NA_character_, 'st' = NA_character_, 'dvt' = NA_character_, 'vap' = NA_character_, 'pvap' = NA_character_
      ) %>%
        dplyr::rename_with(~paste0("cand_", .), .cols = dplyr::everything())
    }

    cand <- cand %>%
      dplyr::rename_with(~paste0("raiz_", .), .cols = dplyr::everything()) %>%
      dplyr::bind_cols((aux))

  } else {
    if (verbose) {cat("request fail :(\n")}
    dplyr::tibble()
  }
}

#' Download dados por UF
#'
#' @param estado sigla UF
#' @param cargo_pretendido cargo pretendido c("prefeito", "vereador")
#' @param t turno (1 ou 2)
#' @param verbose TRUE para ver municípios baixados
#'
#' @return baixa arquivos em CSV
#'
download_uf_ <- function(estado, cargo_pretendido, t, verbose = FALSE) {
  cod <- ibge_tse %>%
    dplyr::filter(uf == estado) %>%
    with(cod_tse_5)
  estado <- tolower(estado)
  cand <- purrr::map_df(cod, download_uf_mun, turno = t, uf = estado, cargo = cargo_pretendido, verbose = verbose) %>%
    dplyr::mutate(uf = toupper(estado), cargo = toupper(cargo_pretendido), turno = t) %>%
    dplyr::mutate(dplyr::across(.fns = stringr::str_squish))

  return(cand)
}

#' Download dados por UF
#'
#' @param estado sigla UF (ou "todos")
#' @param cargo cargo pretendido c("prefeito", "vereador")
#' @param turno turno (1 ou 2)
#' @param verbose TRUE para ver municípios baixados
#' @param path pasta onde salvar os arquivos CSV
#'
#' @return baixa arquivos em CSV
#'
#' @export
#'
download_uf <- function(estado, cargo, turno, path = NULL, verbose = FALSE) {

  if(estado == "todos") {
    t <- ibge_tse %>%
      with(uf) %>%
      unique() %>%
      purrr::map_df(download_uf_, cargo, turno, verbose)
  } else {
    t <- download_uf_(estado, cargo, turno, verbose)
  }

  if(!is.null(path)) {
    dir.create(path, showWarnings = FALSE)
    path <- paste0(path, "/", cargo, "_", turno, "turno_", estado, ".csv") %>%
      gsub("//", "/", .)
    readr::write_csv(t, path)
    if (verbose == TRUE) {
      cat(paste0("\nArquivo salvo em ", path, "\n"))
    }
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
