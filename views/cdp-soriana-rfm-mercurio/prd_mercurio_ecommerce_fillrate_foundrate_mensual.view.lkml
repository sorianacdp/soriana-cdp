view: prd_mercurio_ecommerce_fillrate_foundrate_mensual {
  sql_table_name: `costumer-data-proyect.STG_data.STG_mercurio_ecommerce_fillrate_foundrate_mensual`
    ;;

  dimension: tienda {
    type: string
    sql:  concat(${TABLE}.idTienda ," ",${TABLE}.nombreTienda);;
  }
  dimension: idTienda {
    type: string
    sql: ${TABLE}.idTienda ;;
  }
  dimension: nombreTienda {
    type: string
    sql: ${TABLE}.nombreTienda ;;
  }

  dimension: clientes_recurrentes {
    type: number
    sql: ${TABLE}.clientesRecurrentes ;;
  }

  dimension: fill_rate {
    type: number
    sql: ${TABLE}.fillRate ;;
  }

  dimension: found_rate {
    type: number
    sql: ${TABLE}.foundRate ;;
  }

  dimension: marcaje_tiempo {
    type: number
    sql: ${TABLE}.marcajeTiempo ;;
  }

  dimension: mes {
    type: string
    sql: ${TABLE}.mes ;;
  }

  dimension: ordenes_pendiente_de_cobro {
    type: number
    sql: ${TABLE}.ordenesPendienteDeCobro ;;
  }

  dimension: pedidos {
    type: number
    sql: ${TABLE}.pedidos ;;
  }

  dimension: per_cancelaciones {
    type: number
    sql: ${TABLE}.perCancelaciones ;;
  }

  dimension: per_clientes_recurrentes {
    type: number
    sql: ${TABLE}.perClientesRecurrentes ;;
  }

  dimension: piezas_encontradas {
    type: number
    sql: ${TABLE}.piezasEncontradas ;;
  }

  dimension: piezas_encontradas_reemplazadas {
    type: number
    sql: ${TABLE}.piezasEncontradasReemplazadas ;;
  }

  dimension: piezas_pedidas {
    type: number
    sql: ${TABLE}.piezasPedidas ;;
  }

  dimension: ticket_promedio {
    type: number
    sql: ${TABLE}.ticketPromedio ;;
  }

  dimension: total_clientes {
    type: number
    sql: ${TABLE}.totalClientes ;;
  }

  dimension: ventas {
    type: number
    sql: ${TABLE}.ventas ;;
  }


  measure: avgOrdenes {
    type: average
    sql: ${TABLE}.Pedidos ;;
  }
  measure: avgTicketPromedio {
    type: average
    sql: ${TABLE}.ticketPromedio ;;
  }
  measure: avgVentas {
    type: average
    sql: ${TABLE}.ventas ;;
  }
  measure: avgClientesRecurrentes {
    type: average
    sql: ${TABLE}.clientesRecurrentes ;;
  }
  measure: avgOrdenesCanceladas {
    type: average
    sql: ${TABLE}.clientesRecurrentes ;;
  }
  measure: avgPerCancelacion {
    type: average
    sql: ${TABLE}.perCancelaciones ;;
  }
  measure: avgFoundRate {
    type: average
    sql: ${TABLE}.foundRate ;;
  }
  measure: avgFillRate {
    type: average
    sql: ${TABLE}.fillRate ;;
  }
  measure: avgMarcajeTiempo {
    type: average
    sql: ${TABLE}.marcajeTiempo ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
