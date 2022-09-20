view: cdp_soriana_segmentacion_dinamico {
  derived_table: {
    sql: SELECT *
        FROM `costumer-data-proyect.customer_data_platform.cdp-soriana-RFM_LTV`
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: countdistinct {
    type: count_distinct
    sql: ${TABLE}.idCliente ;;
  }

  dimension: id_cliente {
    type: string
    sql: ${TABLE}.idCliente ;;
  }

  dimension: GRClienteId {
    type: string
    sql: ${TABLE}.GRClienteId ;;
  }

  dimension: idTienda {
    type: string
    sql: ${TABLE}.idTienda ;;
  }

  dimension: Tienda {
    type: string
    sql: ${TABLE}.Tienda ;;
  }

  dimension: Formato {
    type: string
    sql: ${TABLE}.Formato ;;
  }

  dimension: Estado {
    type: string
    sql: ${TABLE}.Estado ;;
  }


  dimension: origenCliente {
    type: string
    sql: ${TABLE}.origenCliente ;;
  }

  dimension: fechaNacimientoSoriana {
    type: string
    sql: ${TABLE}.fechaNacimientoSoriana ;;
  }


  dimension: fecha_nacimiento {
    type: string
    sql: ${TABLE}.fechaNacimiento ;;
  }

  dimension: sexo {
    type: string
    sql: ${TABLE}.sexo ;;
  }

  dimension: semana {
    type: string
    sql: ${TABLE}.semana ;;
  }

  dimension: haceNSemanas {
    type: number
    sql: ${TABLE}.haceNSemanas ;;
  }

##########################################################################
#################


  #dimension: enlaces {
  #  type: string
  #  html:;;
  #}

  set: detail {
    fields: [
      id_cliente,
      GRClienteId,
      idTienda,
      origenCliente,

      fechaNacimientoSoriana,
      fecha_nacimiento,
      sexo,
      semana,
      haceNSemanas]
  }
}
