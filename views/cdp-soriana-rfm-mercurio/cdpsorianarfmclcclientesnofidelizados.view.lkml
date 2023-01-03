view: cdpsorianarfmclcclientesnofidelizados {
  sql_table_name: `costumer-data-proyect.calculos_rfm_clc.cdp-soriana-rfm-clc-clientes-no-fidelizados`
    ;;

  measure: countdistinctEmail {
    type: count_distinct
    sql: ${TABLE}.customerEmail ;;
  }

#####################conteo de clientes por calificacion

  measure: clientePerdido {
    type: count_distinct
    sql: ${TABLE}.customerEmail ;;
    filters: [bucket: "Perdido"]
  }

  measure: clienteDormido {
    type: count_distinct
    sql: ${TABLE}.customerEmail ;;
    filters: [bucket: "Dormido"]
  }

  measure: clienteEnriesgo {
    type: count_distinct
    sql: ${TABLE}.customerEmail ;;
    filters: [bucket: "En riesgo"]
  }

  measure: clienteNuevos {
    type: count_distinct
    sql: ${TABLE}.customerEmail ;;
    filters: [bucket: "Nuevos"]
  }

  measure: clienteOcasional {
    type: count_distinct
    sql: ${TABLE}.customerEmail ;;
    filters: [bucket: "Ocasional/No comprometido"]
  }

  measure: clientePotencial {
    type: count_distinct
    sql: ${TABLE}.customerEmail ;;
    filters: [bucket: "Potencial"]
  }

  measure: clientePremium {
    type: count_distinct
    sql: ${TABLE}.customerEmail ;;
    filters: [bucket: "Premium"]
  }

  measure: clienteValioso {
    type: count_distinct
    sql: ${TABLE}.customerEmail ;;
    filters: [bucket: "Valioso"]
  }

  measure: sumaGastoAcumulado{
    type: sum
    sql: ${TABLE}.totalCompras8semanas ;;
  }


  dimension: apellido_materno {
    type: string
    sql: ${TABLE}.ApellidoMaterno ;;
  }

  dimension: apellido_paterno {
    type: string
    sql: ${TABLE}.ApellidoPaterno ;;
  }

  dimension: bucket {
    type: string
    sql: ${TABLE}.bucket ;;
  }

  dimension: conteo_compras8semanas {
    type: number
    sql: ${TABLE}.conteoCompras8semanas ;;
  }

  dimension: conteo_ordenes {
    type: number
    sql: ${TABLE}.conteoOrdenes ;;
  }

  dimension: correo {
    type: string
    sql: ${TABLE}.correo ;;
  }

  dimension: customer_email {
    type: string
    sql: ${TABLE}.customerEmail ;;
  }

  dimension: dias_de_vida {
    type: number
    sql: ${TABLE}.diasDeVida ;;
  }

  dimension: dias_sin_compra {
    type: number
    sql: ${TABLE}.diasSinCompra ;;
  }

  dimension_group: fecha {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.fecha ;;
  }

  dimension_group: fecha_primera_compra {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.fechaPrimeraCompra ;;
  }

  dimension_group: fecha_ultima_compra {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.fechaUltimaCompra ;;
  }

  dimension_group: fechade_nacimiento {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.FechadeNacimiento ;;
  }

  dimension: frecuencia8semanas {
    type: number
    sql: ${TABLE}.frecuencia8semanas ;;
  }

  dimension: grcliente_id {
    type: string
    sql: ${TABLE}.GRClienteId ;;
  }

  dimension: id_programa_recompensas {
    type: string
    sql: ${TABLE}.IdProgramaRecompensas ;;
  }

  dimension: news_letters {
    type: string
    sql: ${TABLE}.NewsLetters ;;
  }

  dimension: nombre {
    type: string
    sql: ${TABLE}.Nombre ;;
  }

  dimension: rango_frecuencia8semanas {
    type: string
    sql: ${TABLE}.rangoFrecuencia8semanas ;;
  }

  dimension: saldo_puntos_pr {
    type: string
    sql: ${TABLE}.SaldoPuntosPR ;;
  }

  dimension: semanas_con_compra8semanas {
    type: number
    sql: ${TABLE}.semanasConCompra8semanas ;;
  }

  dimension: semanas_sin_compra {
    type: number
    sql: ${TABLE}.semanasSinCompra ;;
  }

  dimension: sfcustomer_no {
    type: string
    sql: ${TABLE}.SFCustomerNo ;;
  }

  dimension: telefono {
    type: string
    sql: ${TABLE}.Telefono ;;
  }

  dimension: ticket_promedio {
    type: number
    sql: ${TABLE}.TicketPromedio ;;
  }

  dimension: tikect_promedio_compras8semanas {
    type: number
    sql: ${TABLE}.tikectPromedioCompras8semanas ;;
  }

  dimension: tipo_a {
    type: string
    sql: ${TABLE}.tipoA ;;
  }

  dimension: tipo_b {
    type: string
    sql: ${TABLE}.tipoB ;;
  }

  dimension: total_compras8semanas {
    type: number
    sql: ${TABLE}.totalCompras8semanas ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }




}
