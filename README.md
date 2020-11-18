
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eleicoesmun2020

<!-- badges: start -->
<!-- badges: end -->

Uma forma mais fácil de ler os dados simplificados das eleições
municipais de 2020 do TSE. Os dados são puxados diretamente da API do
TSE.

O pacote foi feito com ajuda do código do [Marco Antonio
Faganello](https://github.com/marcofaga/eleicoes2020).

## Instalação

Para instalar o pacote:

``` r
# install.packages("devtools")
devtools::install_github("rmhirota/eleicoesmun2020")
```

## Exemplo

Baixando dados de eleições à prefeitura em Roraima:

``` r
library(eleicoesmun2020)

download_uf(estado = "RR", cargo = "prefeito", path = "csv")
#> # A tibble: 65 x 74
#>    raiz_ele raiz_tpabr raiz_cdabr raiz_carper raiz_t raiz_f raiz_dt raiz_ht
#>    <chr>    <chr>      <chr>      <chr>       <chr>  <chr>  <chr>   <chr>  
#>  1 426      mu         03042      11          1      o      15/11/… 21:37:…
#>  2 426      mu         03042      11          1      o      15/11/… 21:37:…
#>  3 426      mu         03042      11          1      o      15/11/… 21:37:…
#>  4 426      mu         03042      11          1      o      15/11/… 21:37:…
#>  5 426      mu         03042      11          1      o      15/11/… 21:37:…
#>  6 426      mu         03050      11          1      o      15/11/… 21:10:…
#>  7 426      mu         03050      11          1      o      15/11/… 21:10:…
#>  8 426      mu         03050      11          1      o      15/11/… 21:10:…
#>  9 426      mu         03018      11          1      o      15/11/… 22:00:…
#> 10 426      mu         03018      11          1      o      15/11/… 22:00:…
#> # … with 55 more rows, and 66 more variables: raiz_dv <chr>, raiz_tf <chr>,
#> #   raiz_v <chr>, raiz_esae <chr>, raiz_mnae <chr>, raiz_s <chr>,
#> #   raiz_st <chr>, raiz_pst <chr>, raiz_snt <chr>, raiz_psnt <chr>,
#> #   raiz_si <chr>, raiz_psi <chr>, raiz_sni <chr>, raiz_psni <chr>,
#> #   raiz_sa <chr>, raiz_psa <chr>, raiz_sna <chr>, raiz_psna <chr>,
#> #   raiz_e <chr>, raiz_ea <chr>, raiz_pea <chr>, raiz_ena <chr>,
#> #   raiz_pena <chr>, raiz_esi <chr>, raiz_pesi <chr>, raiz_esni <chr>,
#> #   raiz_pesni <chr>, raiz_c <chr>, raiz_pc <chr>, raiz_a <chr>, raiz_pa <chr>,
#> #   raiz_vscv <chr>, raiz_vnom <chr>, raiz_pvnom <chr>, raiz_vvc <chr>,
#> #   raiz_pvvc <chr>, raiz_vb <chr>, raiz_pvb <chr>, raiz_tvn <chr>,
#> #   raiz_ptvn <chr>, raiz_vn <chr>, raiz_pvn <chr>, raiz_vnt <chr>,
#> #   raiz_pvnt <chr>, raiz_vp <chr>, raiz_pvp <chr>, raiz_vv <chr>,
#> #   raiz_pvv <chr>, raiz_van <chr>, raiz_pvan <chr>, raiz_vansj <chr>,
#> #   raiz_pvansj <chr>, raiz_tv <chr>, cand_seq <chr>, cand_sqcand <chr>,
#> #   cand_n <chr>, cand_nm <chr>, cand_cc <chr>, cand_nv <chr>, cand_e <chr>,
#> #   cand_st <chr>, cand_dvt <chr>, cand_vap <chr>, cand_pvap <chr>, uf <chr>,
#> #   cargo <chr>
```

A função retornará uma tabela com os dados, além de salvar um arquivo
.csv na pasta indicada em `path`. Caso não queira salvar o arquivo,
basta ignorar o parâmetro, como no exemplo a seguir:

``` r
library(eleicoesmun2020)

download_uf(estado = "RR", cargo = "prefeito")
#> # A tibble: 65 x 74
#>    raiz_ele raiz_tpabr raiz_cdabr raiz_carper raiz_t raiz_f raiz_dt raiz_ht
#>    <chr>    <chr>      <chr>      <chr>       <chr>  <chr>  <chr>   <chr>  
#>  1 426      mu         03042      11          1      o      15/11/… 21:37:…
#>  2 426      mu         03042      11          1      o      15/11/… 21:37:…
#>  3 426      mu         03042      11          1      o      15/11/… 21:37:…
#>  4 426      mu         03042      11          1      o      15/11/… 21:37:…
#>  5 426      mu         03042      11          1      o      15/11/… 21:37:…
#>  6 426      mu         03050      11          1      o      15/11/… 21:10:…
#>  7 426      mu         03050      11          1      o      15/11/… 21:10:…
#>  8 426      mu         03050      11          1      o      15/11/… 21:10:…
#>  9 426      mu         03018      11          1      o      15/11/… 22:00:…
#> 10 426      mu         03018      11          1      o      15/11/… 22:00:…
#> # … with 55 more rows, and 66 more variables: raiz_dv <chr>, raiz_tf <chr>,
#> #   raiz_v <chr>, raiz_esae <chr>, raiz_mnae <chr>, raiz_s <chr>,
#> #   raiz_st <chr>, raiz_pst <chr>, raiz_snt <chr>, raiz_psnt <chr>,
#> #   raiz_si <chr>, raiz_psi <chr>, raiz_sni <chr>, raiz_psni <chr>,
#> #   raiz_sa <chr>, raiz_psa <chr>, raiz_sna <chr>, raiz_psna <chr>,
#> #   raiz_e <chr>, raiz_ea <chr>, raiz_pea <chr>, raiz_ena <chr>,
#> #   raiz_pena <chr>, raiz_esi <chr>, raiz_pesi <chr>, raiz_esni <chr>,
#> #   raiz_pesni <chr>, raiz_c <chr>, raiz_pc <chr>, raiz_a <chr>, raiz_pa <chr>,
#> #   raiz_vscv <chr>, raiz_vnom <chr>, raiz_pvnom <chr>, raiz_vvc <chr>,
#> #   raiz_pvvc <chr>, raiz_vb <chr>, raiz_pvb <chr>, raiz_tvn <chr>,
#> #   raiz_ptvn <chr>, raiz_vn <chr>, raiz_pvn <chr>, raiz_vnt <chr>,
#> #   raiz_pvnt <chr>, raiz_vp <chr>, raiz_pvp <chr>, raiz_vv <chr>,
#> #   raiz_pvv <chr>, raiz_van <chr>, raiz_pvan <chr>, raiz_vansj <chr>,
#> #   raiz_pvansj <chr>, raiz_tv <chr>, cand_seq <chr>, cand_sqcand <chr>,
#> #   cand_n <chr>, cand_nm <chr>, cand_cc <chr>, cand_nv <chr>, cand_e <chr>,
#> #   cand_st <chr>, cand_dvt <chr>, cand_vap <chr>, cand_pvap <chr>, uf <chr>,
#> #   cargo <chr>
```

Para baixar informações de *todos* os estados, basta usar o parâmetro
`estado = "todos"`.

## Principais variáveis

| coluna       | descricao                                   |
|:-------------|:--------------------------------------------|
| cand\_sqcand | id único do candidato                       |
| cand\_n      | número do candidato na urna                 |
| cand\_nm     | nome do candidato                           |
| cand\_e      | eleito (sim ou não)                         |
| raiz\_tf     | totalização final (sim ou não)              |
| raiz\_tv     | total de votos                              |
| cand\_vap    | quantidade de votos computados ao candidato |

Para entender as informações de cada coluna, verifique a [documentação
do
TSE](https://www.tse.jus.br/eleicoes/eleicoes-2020/arquivos/ea04-arquivo-de-resultado-consolidado-01-2020/rybena_pdf?file=https://www.tse.jus.br/eleicoes/eleicoes-2020/arquivos/ea04-arquivo-de-resultado-consolidado-01-2020/at_download/file).
