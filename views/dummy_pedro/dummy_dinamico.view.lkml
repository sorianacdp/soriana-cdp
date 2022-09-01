view: dummy_dinamico {
  derived_table: {
    sql: SELECT * EXCEPT (tipoCliente)
        FROM `costumer-data-proyect.customer_data_platform.cdp-soriana-segmentacionClientesCLC`
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id_cliente {
    type: string
    sql: ${TABLE}.idCliente ;;
  }

  dimension: semana {
    type: string
    sql: ${TABLE}.semana ;;
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
    fields: [id_cliente, semana, ticke_total, conteo_compras, ticket_promedio]
  }
}
