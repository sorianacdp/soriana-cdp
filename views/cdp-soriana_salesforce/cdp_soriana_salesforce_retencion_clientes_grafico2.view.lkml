view: cdp_soriana_salesforce_retencion_clientes_grafico2 {
  derived_table: {
    sql: SELECT *, CAST(REGEXP_EXTRACT(meses, r'[0-9]+') AS INT64) mesNumber FROM(
      SELECT
        macroCanal,
        AVG(mes0) mes0,AVG(mes1) mes1,AVG(mes2) mes2,AVG(mes3) mes3,AVG(mes4) mes4,AVG(mes5) mes5,AVG(mes6) mes6,AVG(mes7) mes7,AVG(mes8) mes8,
        AVG(mes9) mes9,AVG(mes10) mes10,AVG(mes11) mes11,AVG(mes12) mes12,AVG(mes13) mes13,AVG(mes14) mes14,AVG(mes15) mes15,AVG(mes16) mes16,AVG(mes17) mes17,AVG(mes18) mes18,
        AVG(mes19) mes19,AVG(mes20) mes20,AVG(mes21) mes21,AVG(mes22) mes22,AVG(mes23) mes23,AVG(mes24) mes24,AVG(mes25) mes25,AVG(mes26) mes26,AVG(mes27) mes27
      FROM `costumer-data-proyect.PRD_data.PRD_salesforce_metrica_retencion_clientes_mensual` GROUP BY 1
    )
    UNPIVOT(valor FOR meses IN (mes0,mes1,mes2,mes3,mes4,mes5,mes6,mes7,mes8,mes9,mes10,mes11,mes12,mes13,mes14,mes15,mes16,mes17,mes18,mes19,mes20,mes21,mes22,mes23,mes24,mes25,mes26,mes27))
    -- WHERE CAST(REGEXP_EXTRACT(meses, r'[0-9]+') AS INT64)<=22 -- mes maximo a visualizar
    ORDER BY CAST(REGEXP_EXTRACT(meses, r'[0-9]+') AS INT64) ASC ;;
  }

  dimension: macroCanal{
    type: string
    sql: ${TABLE}.macroCanal ;;
  }
  dimension: porcentage{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.valor ;;
  }

  dimension: meses {
    type: number
    value_format: "0"
    sql: ${TABLE}.mesNumber ;;
  }

  set: detail {
    fields: [
      macroCanal,
      porcentage,
      meses
    ]
  }
}
