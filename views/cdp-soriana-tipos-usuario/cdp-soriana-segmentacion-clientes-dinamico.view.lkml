view: cdp-soriana-segmentacion-clientes-dinamico {
  derived_table: {
    sql: SELECT *
        FROM `costumer-data-proyect.customer_data_platform.cdp-soriana-segmentacionClientesCLC`
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_distinct {
    type: count_distinct
    sql: ${TABLE}.idCliente ;;
  }


  measure: clientePremium {
    type: count_distinct
    sql: ${TABLE}.idCliente ;;
    filters: [tipoCliente2: "CLIENTE PREMIUM"]
  }

  measure: clienteValioso {
    type: count_distinct
    sql: ${TABLE}.idCliente ;;
    filters: [tipoCliente2: "CLIENTE VALIOSO"]
  }

  measure: clientePotencial {
    type: count_distinct
    sql: ${TABLE}.idCliente ;;
    filters: [tipoCliente2: "CLIENTE POTENCIAL"]
  }

  measure: clienteNoComprometido {
    type: count_distinct
    sql: ${TABLE}.idCliente ;;
    filters: [tipoCliente2: "NO COMPROMETIDO"]
  }

  measure: clienteNuevo {
    type: count_distinct
    sql: ${TABLE}.idCliente ;;
    filters: [tipoCliente2: "CLIENTE NUEVO"]
  }

  measure: clienteProspecto {
    type: count_distinct
    sql: ${TABLE}.idCliente ;;
    filters: [tipoCliente2: "CLIENTE PROSPECTO"]
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

  dimension: origenCliente {
    type: string
    sql: ${TABLE}.origenCliente ;;
  }

  dimension: omnicanal {
    type: string
    sql: ${TABLE}.omnicanal ;;
  }

  dimension: fechaNacimientoSoriana {
    type: string
    sql: ${TABLE}.fechaNacimientoSoriana ;;
  }

  dimension: nombre {
    type: string
    sql: ${TABLE}.nombre ;;
  }

  dimension: apellido {
    type: string
    sql: ${TABLE}.apellido ;;
  }

  dimension: fecha_nacimiento {
    type: string
    sql: ${TABLE}.fechaNacimiento ;;
  }

  dimension: sexo {
    type: string
    sql: ${TABLE}.sexo ;;
  }

  dimension: correo {
    type: string
    sql: ${TABLE}.correo ;;
  }


  dimension: semana {
    type: string
    sql: ${TABLE}.semana ;;
  }

  dimension: haceNSemanas {
    type: number
    sql: ${TABLE}.haceNSemanas ;;
  }

  dimension: anio {
    type: string
    sql: ${TABLE}.anio ;;
  }

  dimension: ticke_total {
    type: number
    sql: ${TABLE}.tickeTotal ;;
  }

  dimension: conteo_compras {
    type: number
    sql: ${TABLE}.conteoCompras ;;
  }

  dimension: ticket_promedio {
    type: number
    sql: ${TABLE}.ticketPromedio ;;
  }


  filter: aniofilter {
    type: yesno
    sql: ${TABLE}.anio;;
  }
##########################################################################


parameter: limSupCalClient {
  type: unquoted
  default_value: "570"
  allowed_value: {value: "570"}
  allowed_value: {value: "2000"}
  allowed_value: {value: "3000"}
  allowed_value: {value: "3500"}
}

  parameter: limInfCalClient {
    type: unquoted
    default_value: "150"
    allowed_value: {value: "150"}
    allowed_value: {value: "200"}
    allowed_value: {value: "250"}
    allowed_value: {value: "300"}
    allowed_value: {value: "350"}
    allowed_value: {value: "400"}

  }

  parameter: conteoR4{
    type: unquoted
    default_value: "4"
    allowed_value: {value: "4"}
    allowed_value: {value: "5"}
    allowed_value: {value: "6"}
    allowed_value: {value: "7"}
    allowed_value: {value: "8"}
  }
  parameter: conteoR3 {
    type: unquoted
    default_value: "3"
    allowed_value: {value: "3"}
    allowed_value: {value: "4"}
    allowed_value: {value: "5"}

  }

  parameter: conteoR1 {
    type: unquoted
    default_value: "1"
    allowed_value: {value: "1"}
    allowed_value: {value: "2"}
    allowed_value: {value: "3"}
  }
  parameter: conteoR0 {
    type: unquoted
    default_value: "0"
    allowed_value: {value: "0"}
    allowed_value: {value: "1"}
  }

  dimension: tipoCliente2 {
    case: {
    #cliente nuevo
      when: {
        sql: ${TABLE}.conteoCompras = {% parameter conteoR1%} ;;
        label: "CLIENTE NUEVO"
      }
    #cliente prospecto
      when: {
        sql: ${TABLE}.conteoCompras = {% parameter conteoR0%} ;;
        label: "CLIENTE PROSPECTO"
      }
   #cliente premium
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR4%}) and (${TABLE}.ticketPromedio > {% parameter limSupCalClient%})   ;;
        label: "CLIENTE PREMIUM"
      }

    #cliente valiosos
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR3%} and ${TABLE}.conteoCompras < {% parameter conteoR4%} ) and (${TABLE}.ticketPromedio > {% parameter limSupCalClient%}) ;;
        label: "CLIENTE VALIOSO"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR4%}) and (${TABLE}.ticketPromedio >= {% parameter limInfCalClient%} and ${TABLE}.ticketPromedio <= {% parameter limSupCalClient%}) ;;
        label: "CLIENTE VALIOSO"
      }

      #cliente potencial
      when: {
        sql: (${TABLE}.conteoCompras > {% parameter conteoR1%} and ${TABLE}.conteoCompras < {% parameter conteoR3%} ) and (${TABLE}.ticketPromedio > {% parameter limSupCalClient%}) ;;
        label: "CLIENTE POTENCIAL"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR3%} and ${TABLE}.conteoCompras < {% parameter conteoR4%}) and (${TABLE}.ticketPromedio >= {% parameter limInfCalClient%} and ${TABLE}.ticketPromedio <= {% parameter limSupCalClient%}) ;;
        label: "CLIENTE POTENCIAL"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR4%}) and (${TABLE}.ticketPromedio < {% parameter limInfCalClient%} ) ;;
        label: "CLIENTE POTENCIAL"
      }

      # cliente no comprometido
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR3%} and ${TABLE}.conteoCompras < {% parameter conteoR4%}) and (${TABLE}.ticketPromedio < {% parameter limInfCalClient%} ) ;;
        label: "NO COMPROMETIDO"
      }
      when: {
        sql: (${TABLE}.conteoCompras > {% parameter conteoR1%} and ${TABLE}.conteoCompras < {% parameter conteoR3%}) and (${TABLE}.ticketPromedio < {% parameter limInfCalClient%} ) ;;
        label: "NO COMPROMETIDO"
      }
      when: {
        sql: (${TABLE}.conteoCompras > {% parameter conteoR1%} and ${TABLE}.conteoCompras <  {% parameter conteoR3%}) and (${TABLE}.ticketPromedio >= {% parameter limInfCalClient%} and ${TABLE}.ticketPromedio <= {% parameter limSupCalClient%}) ;;
        label: "NO COMPROMETIDO"
      }

      else: "(not set)"
    }
  }



  set: detail {
    fields: [id_cliente,
      GRClienteId,
      idTienda,
      origenCliente,
      omnicanal,
      fechaNacimientoSoriana,
      nombre,
      apellido,
      fecha_nacimiento,
      sexo,
      correo,
      semana,
      haceNSemanas,
      anio,
      ticke_total,
      conteo_compras,
      ticket_promedio,
      tipoCliente2]
  }
}
