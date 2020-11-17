
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eleicoesmun2020

<!-- badges: start -->
<!-- badges: end -->

Uma forma mais fácil de ler os dados simplificados das eleições
municipais de 2020 do TSE. Os dados são puxados diretamente da API do
TSE.

## Instalação

Para instalar o pacote, rode:

``` r
# install.packages("devtools")
devtools::install_github("rmhirota/eleicoesmun2020")
```

## Exemplo

Baixando dados de eleições à prefeitura em Roraima:

``` r
library(eleicoesmun2020)

download_uf(estado = "RR", cargo = "prefeito", path = "csv")
#> # A tibble: 65 x 15
#>    seq   sqcand n     nm    cc    nv    e     st    dvt   vap   pvap  turno
#>    <chr> <chr>  <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 3     23000… 77    VAST… SOLI… THIA… n     Não … Váli… 1126  "  2… 1    
#>  2 2     23000… 22    GLEY… PL -… ANDE… n     Não … Váli… 1445  "  2… 1    
#>  3 5     23000… 43    ANAR… PV    TUXA… n     Não … Váli… 299   "   … 1    
#>  4 4     23000… 10    ZANZ… REPU… PAST… n     Não … Váli… 628   "  1… 1    
#>  5 1     23000… 15    NUBI… MDB … OZEAS s     Elei… Váli… 1548  "  3… 1    
#>  6 2     23000… 22    WAGN… PL -… JOSÉ… n     Não … Váli… 2947  "  3… 1    
#>  7 3     23000… 10    ERLE… REPU… RAIM… n     Não … Váli… 1724  "  2… 1    
#>  8 1     23000… 55    PEDR… PSD … SIMO… s     Elei… Váli… 3928  "  4… 1    
#>  9 9     23000… 50    FABI… PSOL  THIA… n     Não … Váli… 1130  "   … 1    
#> 10 6     23000… 19    PR I… PODE  MAJO… n     Não … Váli… 8303  "   … 1    
#> # … with 55 more rows, and 3 more variables: totalizacao_final <chr>, uf <chr>,
#> #   cargo_pretendido <chr>
```

A função retornará uma tabela com os dados, além de salvar um arquivo
.csv na pasta indicada em `path`. Caso não queira salvar o arquivo,
basta ignorar o parâmetro:

``` r
library(eleicoesmun2020)

download_uf(estado = "RR", cargo = "prefeito")
#> # A tibble: 65 x 15
#>    seq   sqcand n     nm    cc    nv    e     st    dvt   vap   pvap  turno
#>    <chr> <chr>  <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr> <chr>
#>  1 3     23000… 77    VAST… SOLI… THIA… n     Não … Váli… 1126  "  2… 1    
#>  2 2     23000… 22    GLEY… PL -… ANDE… n     Não … Váli… 1445  "  2… 1    
#>  3 5     23000… 43    ANAR… PV    TUXA… n     Não … Váli… 299   "   … 1    
#>  4 4     23000… 10    ZANZ… REPU… PAST… n     Não … Váli… 628   "  1… 1    
#>  5 1     23000… 15    NUBI… MDB … OZEAS s     Elei… Váli… 1548  "  3… 1    
#>  6 2     23000… 22    WAGN… PL -… JOSÉ… n     Não … Váli… 2947  "  3… 1    
#>  7 3     23000… 10    ERLE… REPU… RAIM… n     Não … Váli… 1724  "  2… 1    
#>  8 1     23000… 55    PEDR… PSD … SIMO… s     Elei… Váli… 3928  "  4… 1    
#>  9 9     23000… 50    FABI… PSOL  THIA… n     Não … Váli… 1130  "   … 1    
#> 10 6     23000… 19    PR I… PODE  MAJO… n     Não … Váli… 8303  "   … 1    
#> # … with 55 more rows, and 3 more variables: totalizacao_final <chr>, uf <chr>,
#> #   cargo_pretendido <chr>
```

Para baixar informações de *todos* os estados, basta usar o parâmetro
`estado = "todos"`.

## Principais variáveis

| coluna             | descricao                      |
|:-------------------|:-------------------------------|
| sqcand             | id único do candidato          |
| nm                 | nome do candidato              |
| e                  | eleito (sim ou não)            |
| totalizacao\_final | totalização final (sim ou não) |

Para entender as informações de cada coluna, verifique a [documentação
do
TSE](https://www.tse.jus.br/eleicoes/eleicoes-2020/arquivos/ea04-arquivo-de-resultado-consolidado-01-2020/rybena_pdf?file=https://www.tse.jus.br/eleicoes/eleicoes-2020/arquivos/ea04-arquivo-de-resultado-consolidado-01-2020/at_download/file).
