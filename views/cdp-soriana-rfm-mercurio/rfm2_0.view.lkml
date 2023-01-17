view: rfm2_0 {
  derived_table: {
    sql: SELECT * FROM `costumer-data-proyect.calculos_rfm_clc.cdp-soriana-rfm-ecommerce` LIMIT 10
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: customer_email {
    type: string
    sql: ${TABLE}.customerEmail ;;
  }

  dimension: rango_inicial_semana {
    type: date
    datatype: date
    sql: ${TABLE}.rangoInicialSemana ;;
  }

  dimension: rango_final_semana {
    type: date
    datatype: date
    sql: ${TABLE}.rangoFinalSemana ;;
  }

  dimension: semana {
    type: number
    sql: ${TABLE}.semana ;;
  }

  dimension: fecha_primera_compra_de_la_semana {
    type: date
    datatype: date
    sql: ${TABLE}.fechaPrimeraCompraDeLaSemana ;;
  }

  dimension: fecha_ultima_compra_de_la_semana {
    type: date
    datatype: date
    sql: ${TABLE}.fechaUltimaCompraDeLaSemana ;;
  }

  dimension: semana_sin_compra {
    type: number
    sql: ${TABLE}.semanaSinCompra ;;
  }

  dimension: semana_con_compra {
    type: number
    sql: ${TABLE}.semanaConCompra ;;
  }

  dimension: ordenes_semana {
    type: number
    sql: ${TABLE}.ordenesSemana ;;
  }

  dimension: gasto_semana {
    type: number
    sql: ${TABLE}.gastoSemana ;;
  }

  dimension: ordenes_semana_total {
    type: number
    sql: ${TABLE}.ordenesSemanaTotal ;;
  }

  dimension: gasto_semana_total {
    type: number
    sql: ${TABLE}.gastoSemanaTotal ;;
  }

  dimension: tickect_promedio_total_de_la_semana {
    type: number
    sql: ${TABLE}.tickectPromedioTotalDeLaSemana ;;
  }

  dimension: ordenes8_sem {
    type: number
    sql: ${TABLE}.ordenes8Sem ;;
  }

  dimension: total_gasto8_sem {
    type: number
    sql: ${TABLE}.totalGasto8Sem ;;
  }

  dimension: semanas_con_compra8_sem {
    type: number
    sql: ${TABLE}.semanasConCompra8Sem ;;
  }

  dimension: ticket_promedio8_sem {
    type: number
    sql: ${TABLE}.TicketPromedio8Sem ;;
  }

  dimension: rango_frecuencia8sem {
    type: string
    sql: ${TABLE}.rangoFrecuencia8sem ;;
  }

  dimension: frecuencia8_sem {
    type: number
    sql: ${TABLE}.frecuencia8Sem ;;
  }

  dimension: fecha_historica_primera_compra {
    type: date
    datatype: date
    sql: ${TABLE}.fechaHistoricaPrimeraCompra ;;
  }

  dimension: fecha_primera_compra8_sem {
    type: date
    datatype: date
    sql: ${TABLE}.fechaPrimeraCompra8Sem ;;
  }

  dimension: fecha_ultima_compra8_sem {
    type: date
    datatype: date
    sql: ${TABLE}.fechaUltimaCompra8Sem ;;
  }

  dimension: dias_sin_compra {
    type: number
    sql: ${TABLE}.diasSinCompra ;;
  }

  dimension: semanas_sin_compra {
    type: number
    sql: ${TABLE}.semanasSinCompra ;;
  }

  dimension: dias_de_vida {
    type: number
    sql: ${TABLE}.diasDeVida ;;
  }

  dimension: bucket {
    type: string
    sql: ${TABLE}.bucket ;;
  }

  set: detail {
    fields: [
      customer_email,
      rango_inicial_semana,
      rango_final_semana,
      semana,
      fecha_primera_compra_de_la_semana,
      fecha_ultima_compra_de_la_semana,
      semana_sin_compra,
      semana_con_compra,
      ordenes_semana,
      gasto_semana,
      ordenes_semana_total,
      gasto_semana_total,
      tickect_promedio_total_de_la_semana,
      ordenes8_sem,
      total_gasto8_sem,
      semanas_con_compra8_sem,
      ticket_promedio8_sem,
      rango_frecuencia8sem,
      frecuencia8_sem,
      fecha_historica_primera_compra,
      fecha_primera_compra8_sem,
      fecha_ultima_compra8_sem,
      dias_sin_compra,
      semanas_sin_compra,
      dias_de_vida,
      bucket
    ]
  }
}
