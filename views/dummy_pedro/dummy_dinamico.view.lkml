view: dummy_dinamico {
  derived_table: {
    sql: with rango_fecha as (
      select
      --fecha inicio
      max(format_date('%Y%m%d',FechaHoraTicket)) as  fecha_inicio,
      --semana maxima del rango
      cast( format_date('%U', parse_date("%Y%m%d",max(format_date('%Y%m%d',FechaHoraTicket)))) as INT) as max_semana,
      --fecha final 8 semanas antes, o 56 dias--- 10 semanas 70 dias
        format_date('%Y%m%d',DATE_SUB(DATE(max(FechaHoraTicket)), INTERVAL 90 DAY)) as fecha_final,
      from `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`),
      ------------------------------
      --------------------------------
      prep as (
        select
        distinct format_date('%Y%m%d',FechaHoraTicket) as fecha,
        IdClienteSk as clientes,
        count (distinct IdClienteSk) as conteoCompras,
        ImporteVentaNeta as ticket,
        from `costumer-data-proyect.customer_data_platform.cdp_synapse_tickets_productivos`,rango_fecha
        where  format_date('%Y%m%d',FechaHoraTicket) <= rango_fecha.fecha_inicio and  format_date('%Y%m%d',FechaHoraTicket) >=rango_fecha.fecha_final and IdClienteSk is not null
        group by 1,2,4
        )

      select
      --info cliente
      distinct cast(p.clientes as STRING) as idCliente,
      --info compras
      format_date('%U', parse_date("%Y%m%d",fecha)) as semana,
      sum(p.ticket) as tickeTotal,
      sum(p.conteoCompras) as conteoCompras,
      sum(p.ticket)/sum(p.conteoCompras) as ticketPromedio,

      from prep as p
      group by 1,2
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

  parameter: conteoR2 {
    type: unquoted
    default_value: "2"
    allowed_value: {value: "2"}
    allowed_value: {value: "3"}
    allowed_value: {value: "4"}
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

  dimension: tipoCliente {
    case: {

      when: {
        sql: (${TABLE}.conteoCompras = {% parameter conteoR1%} ) ;;
        label: "CLIENTE NUEVO"
      }

      when: {
        sql: (${TABLE}.conteoCompras = {% parameter conteoR0%} ) ;;
        label: "CLIENTE PROSPECTO"
      }

      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR4%}) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras > {% parameter limSupCalClient%})   ;;
        label: "CLIENTE PREMIUM"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR2%} and ${TABLE}.conteoCompras <= {% parameter conteoR3%} ) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras > {% parameter limSupCalClient%}) ;;
        label: "CLIENTE VALIOSO"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR1%} and ${TABLE}.conteoCompras <= {% parameter conteoR2%} ) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras > {% parameter limSupCalClient%}) ;;
        label: "CLIENTE POTENCIAL"
      }

      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR4%}) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras >= {% parameter limInfCalClient%} and ${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras <= {% parameter limSupCalClient%} ) ;;
        label: "CLIENTE VALIOSO"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR2%} and ${TABLE}.conteoCompras <= {% parameter conteoR3%}) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras >= {% parameter limInfCalClient%} and ${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras <= {% parameter limSupCalClient%} ) ;;
        label: "CLIENTE POTENCIAL"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR1%} and ${TABLE}.conteoCompras <= {% parameter conteoR2%}) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras >= {% parameter limInfCalClient%} and ${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras <= {% parameter limSupCalClient%} ) ;;
        label: "NO COMPROMETIDO"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR4%}) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras < {% parameter limInfCalClient%} ) ;;
        label: "CLIENTE POTENCIAL"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR1%} and ${TABLE}.conteoCompras <= {% parameter conteoR3%}) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras < {% parameter limInfCalClient%} ) ;;
        label: "NO COMPROMETIDO"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR2%} and ${TABLE}.conteoCompras <= {% parameter conteoR3%}) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras < {% parameter limInfCalClient%} ) ;;
        label: "NO COMPROMETIDO"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR1%} and ${TABLE}.conteoCompras <= {% parameter conteoR2%}) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras < {% parameter limInfCalClient%} ) ;;
        label: "NO COMPROMETIDO"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR1%} and ${TABLE}.conteoCompras <= {% parameter conteoR2%}) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras >= {% parameter limInfCalClient%} and ${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras <= {% parameter limSupCalClient%} ) ;;
        label: "NO COMPROMETIDO"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR1%} and ${TABLE}.conteoCompras <= {% parameter conteoR3%}) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras >= {% parameter limInfCalClient%} and ${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras <= {% parameter limSupCalClient%} ) ;;
        label: "NO COMPROMETIDO"
      }
      when: {
        sql: (${TABLE}.conteoCompras >= {% parameter conteoR1%} and ${TABLE}.conteoCompras <= {% parameter conteoR3%}) and (${TABLE}.ticketPromedio/ ${TABLE}.conteoCompras > {% parameter limSupCalClient%} ) ;;
        label: "NO COMPROMETIDO"
      }
      else: "(not set)"
    }
  }






  set: detail {
    fields: [id_cliente, semana, ticke_total, conteo_compras, ticket_promedio]
  }
}
