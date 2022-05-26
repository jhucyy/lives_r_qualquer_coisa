
# Carregar pacotes --------------------------------------------------------
library(tidyverse)
library(httr)
library(rvest)



# Extraindo tabela --------------------------------------------------------

url0 <- "https://app.anm.gov.br/SIGBM/Publico/GerenciarPublico"


parametros <- list("startIndex" = 0,
                   "pageSize" = 500,
                   "orderProperty" = "TotalPontuacao",
                   "orderAscending" = FALSE,
                 "DTOGerenciarFiltroPublico[CodigoBarragem]" = 0,
                 "DTOGerenciarFiltroPublico[NecessitaPAEBM]"= FALSE,
                 "DTOGerenciarFiltroPublico[BarragemInseridaPNSB]" = 0,
                 "DTOGerenciarFiltroPublico[PossuiBackUpDam]"= 0,
                "DTOGerenciarFiltroPublico[SituacaoDeclaracaoCondicaoEstabilidade]" = 0)

resposta <- httr::POST(
  url0,
  body = parametros,
  encode = "form"
)

resposta_json <- jsonlite::fromJSON(content(resposta, "text"))

tabela_barragens <- as_tibble(resposta_json$Entities)

ul <- "https://app.anm.gov.br/SIGBM/BarragemPublico/Detalhar/"

detalhamento_barragem <- httr::GET(stringr::str_glue(ul, id_barragem = tabela_barragens$Chave))


# https://www.youtube.com/watch?v=ZekCMY28Uuc&ab_channel=Curso-R
# web scrapping qualquer coisa, parei em 38:14
