view: cdp_soriana_salesforce_retencion_clientes_grafico1 {
  derived_table: {
    sql: SELECT * FROM(
      SELECT  * FROM `costumer-data-proyect.PRD_data.PRD_salesforce_metrica_retencion_clientes_mensual`
      UNION ALL
      SELECT
        0 periodoNacimiento, SUM(totalClientes) totalClientes,macroCanal, AVG(avgDiasVida) avgDiasVida,
        AVG(mes0) mes0,AVG(mes1) mes1,AVG(mes2) mes2,AVG(mes3) mes3,AVG(mes4) mes4,AVG(mes5) mes5,AVG(mes6) mes6,AVG(mes7) mes7,AVG(mes8) mes8,
        AVG(mes9) mes9,AVG(mes10) mes10,AVG(mes11) mes11,AVG(mes12) mes12,AVG(mes13) mes13,AVG(mes14) mes14,AVG(mes15) mes15,AVG(mes16) mes16,AVG(mes17) mes17,AVG(mes18) mes18,
        AVG(mes19) mes19,AVG(mes20) mes20,AVG(mes21) mes21,AVG(mes22) mes22,AVG(mes23) mes23,AVG(mes24) mes24,AVG(mes25) mes25,AVG(mes26) mes26,AVG(mes27) mes27
      FROM `costumer-data-proyect.PRD_data.PRD_salesforce_metrica_retencion_clientes_mensual` GROUP BY 3
    )ORDER BY periodoNacimiento ASC;;
  }

  dimension: periodo{
    type: number
    value_format: "0"
    sql: ${TABLE}.periodoNacimiento ;;
  }
  dimension: macroCanal{
    type: string
    sql: ${TABLE}.macroCanal ;;
  }
  dimension: avgDiasVida{
    type: number
    value_format: "0"
    sql: ${TABLE}.avgDiasVida ;;
  }
  dimension: totalClientes {
    type: number
    value_format: "0"
    sql: ${TABLE}.totalClientes ;;
  }

  dimension: mes0{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes0 ;;
  }
  dimension: mes1{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes1 ;;
  }
  dimension: mes2{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes2 ;;
  }
  dimension: mes3{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes3 ;;
  }
  dimension: mes4{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes4 ;;
  }
  dimension: mes5{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes5 ;;
  }
  dimension: mes6{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes6 ;;
  }
  dimension: mes7{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes7 ;;
  }
  dimension: mes8{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes8 ;;
  }
  dimension: mes9{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes9 ;;
  }
  dimension: mes10{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes10 ;;
  }
  dimension: mes11{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes11 ;;
  }
  dimension: mes12{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes12 ;;
  }
  dimension: mes13{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes13 ;;
  }
  dimension: mes14{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes14 ;;
  }
  dimension: mes15{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes15 ;;
  }
  dimension: mes16{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes16 ;;
  }
  dimension: mes17{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes17 ;;
  }
  dimension: mes18{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes18 ;;
  }
  dimension: mes19{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes19 ;;
  }
  dimension: mes20{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes20 ;;
  }
  dimension: mes21{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes21 ;;
  }
  dimension: mes22{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes22 ;;
  }
  dimension: mes23{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes23 ;;
  }
  dimension: mes24{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes24 ;;
  }
  dimension: mes25{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes25 ;;
  }
  dimension: mes26{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes26 ;;
  }
  dimension: mes27{
    type: number
    value_format: "0\%"
    sql: ${TABLE}.mes27 ;;
  }

  set: detail {
    fields: [
      periodo,
      macroCanal,
      totalClientes,
      mes0,
      mes1,
      mes2,
      mes3,
      mes4,
      mes5,
      mes6,
      mes7,
      mes8,
      mes9,
      mes10,
      mes11,
      mes12,
      mes13,
      mes14,
      mes15,
      mes16,
      mes17,
      mes18,
      mes19,
      mes20,
      mes21,
      mes22,
      mes23,
      mes24,
      mes25,
      mes26,
      mes27
    ]
  }
}
