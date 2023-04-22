
view: prd_mercurio_ecommerce_fillrate_foundrate_semanal {
  derived_table: {
    sql:
      SELECT
        A.idTienda,A.nombreTienda,
        CONCAT(A.fechaInicial,' a ',A.fechaFinal) semana,A.Pedidos Pedidos1,A.piezasPedidas piezasPedidas1,A.piezasEncontradas piezasEncontradas1,A.piezasEncontradasReemplazadas piezasEncontradasReemplazadas1,
          A.totalClientes totalClientes1,A.clientesRecurrentes clientesRecurrentes1,A.perClientesRecurrentes perClientesRecurrentes1,
          A.ventas ventas1,A.ticketPromedio ticketPromedio1,A.foundRate foundRate1,A.fillRate fillRate1,A.pedidosCancelados pedidosCancelados1,
          A.perCancelaciones perCancelaciones1,A.marcajeTiempo marcajeTiempo1,A.ordenesPendienteDeCobro ordenesPendienteDeCobro1,
        CONCAT(B.fechaInicial,' a ',B.fechaFinal) semana2,B.Pedidos Pedidos2,B.piezasPedidas piezasPedidas2,B.piezasEncontradas piezasEncontradas2,B.piezasEncontradasReemplazadas piezasEncontradasReemplazadas2,
          B.totalClientes totalClientes2,B.clientesRecurrentes clientesRecurrentes2,B.perClientesRecurrentes perClientesRecurrentes2,
          B.ventas ventas2,B.ticketPromedio ticketPromedio2,B.foundRate foundRate2,B.fillRate fillRate2,B.pedidosCancelados pedidosCancelados2,
          B.perCancelaciones perCancelaciones2,B.marcajeTiempo marcajeTiempo2,B.ordenesPendienteDeCobro ordenesPendienteDeCobro2,
        CONCAT(C.fechaInicial,' a ',C.fechaFinal) semana3,C.Pedidos Pedidos3,C.piezasPedidas piezasPedidas3,C.piezasEncontradas piezasEncontradas3,C.piezasEncontradasReemplazadas piezasEncontradasReemplazadas3,
          C.totalClientes totalClientes3,C.clientesRecurrentes clientesRecurrentes3,C.perClientesRecurrentes perClientesRecurrentes3,
          C.ventas ventas3,C.ticketPromedio ticketPromedio3,C.foundRate foundRate3,C.fillRate fillRate3,C.pedidosCancelados pedidosCancelados3,
          C.perCancelaciones perCancelaciones3,C.marcajeTiempo marcajeTiempo3,C.ordenesPendienteDeCobro ordenesPendienteDeCobro3,
        CONCAT(D.fechaInicial,' a ',D.fechaFinal) semana4,D.Pedidos Pedidos4,D.piezasPedidas piezasPedidas4,D.piezasEncontradas piezasEncontradas4,D.piezasEncontradasReemplazadas piezasEncontradasReemplazadas4,
          D.totalClientes totalClientes4,D.clientesRecurrentes clientesRecurrentes4,D.perClientesRecurrentes perClientesRecurrentes4,
          D.ventas ventas4,D.ticketPromedio ticketPromedio4,D.foundRate foundRate4,D.fillRate fillRate4,D.pedidosCancelados pedidosCancelados4,
          D.perCancelaciones perCancelaciones4,D.marcajeTiempo marcajeTiempo4,D.ordenesPendienteDeCobro ordenesPendienteDeCobro4
      FROM (SELECT * FROM TIENDAS_TASAS_SEMANALES WHERE semana=4) A
        LEFT JOIN TIENDAS_TASAS_SEMANALES  B ON A.idTienda=B.idTienda AND B.semana=3
        LEFT JOIN TIENDAS_TASAS_SEMANALES C ON A.idTienda=C.idTienda  AND C.semana=2
        LEFT JOIN TIENDAS_TASAS_SEMANALES D ON A.idTienda=D.idTienda  AND D.semana=1
    ;;
  }

  dimension: tienda {
    type: string
    sql:  concat(${TABLE}.idTienda ," ",${TABLE}.nombreTienda);;
  }
  dimension: clientes_recurrentes1 {
    type: number
    sql: ${TABLE}.clientesRecurrentes1 ;;
  }

  dimension: clientes_recurrentes2 {
    type: number
    sql: ${TABLE}.clientesRecurrentes2 ;;
  }

  dimension: clientes_recurrentes3 {
    type: number
    sql: ${TABLE}.clientesRecurrentes3 ;;
  }

  dimension: clientes_recurrentes4 {
    type: number
    sql: ${TABLE}.clientesRecurrentes4 ;;
  }

  #VariablesPendientes
  dimension: porcentaje_clientes_recurrentes1 {
    type: number
    value_format: "0\%"
    sql: ${TABLE}.perClientesRecurrentes1 ;;
  }
  dimension: porcentaje_clientes_recurrentes2 {
    type: number
    value_format: "0\%"
    sql: ${TABLE}.perClientesRecurrentes2 ;;
  }
  dimension: porcentaje_clientes_recurrentes3 {
    type: number
    value_format: "0\%"
    sql: ${TABLE}.perClientesRecurrentes3 ;;
  }
  dimension: porcentaje_clientes_recurrentes4 {
    type: number
    value_format: "0\%"
    sql: ${TABLE}.perClientesRecurrentes4 ;;
  }
  #VariablesPendientes

  dimension: fill_rate1 {
    type: number
    sql: ${TABLE}.fillRate1 ;;
  }

  dimension: fill_rate2 {
    type: number
    sql: ${TABLE}.fillRate2 ;;
  }

  dimension: fill_rate3 {
    type: number
    sql: ${TABLE}.fillRate3 ;;
  }

  dimension: fill_rate4 {
    type: number
    sql: ${TABLE}.fillRate4 ;;
  }

  dimension: found_rate1 {
    type: number
    sql: ${TABLE}.foundRate1 ;;
  }

  dimension: found_rate2 {
    type: number
    sql: ${TABLE}.foundRate2 ;;
  }

  dimension: found_rate3 {
    type: number
    sql: ${TABLE}.foundRate3 ;;
  }

  dimension: found_rate4 {
    type: number
    sql: ${TABLE}.foundRate4 ;;
  }

  dimension: id_tienda {
    type: string
    sql: ${TABLE}.idTienda ;;
  }

  dimension: marcaje_tiempo1 {
    type: number
    sql: ${TABLE}.marcajeTiempo1 ;;
  }

  dimension: marcaje_tiempo2 {
    type: number
    sql: ${TABLE}.marcajeTiempo2 ;;
  }

  dimension: marcaje_tiempo3 {
    type: number
    sql: ${TABLE}.marcajeTiempo3 ;;
  }

  dimension: marcaje_tiempo4 {
    type: number
    sql: ${TABLE}.marcajeTiempo4 ;;
  }

  dimension: nombre_tienda {
    type: string
    sql: ${TABLE}.nombreTienda ;;
  }

  dimension: ordenes_pendiente_de_cobro1 {
    type: number
    sql: ${TABLE}.ordenesPendienteDeCobro1 ;;
  }

  dimension: ordenes_pendiente_de_cobro2 {
    type: number
    sql: ${TABLE}.ordenesPendienteDeCobro2 ;;
  }

  dimension: ordenes_pendiente_de_cobro3 {
    type: number
    sql: ${TABLE}.ordenesPendienteDeCobro3 ;;
  }

  dimension: ordenes_pendiente_de_cobro4 {
    type: number
    sql: ${TABLE}.ordenesPendienteDeCobro4 ;;
  }

  dimension: pedidos1 {
    type: number
    sql: ${TABLE}.Pedidos1 ;;
  }

  dimension: pedidos2 {
    type: number
    sql: ${TABLE}.Pedidos2 ;;
  }

  dimension: pedidos3 {
    type: number
    sql: ${TABLE}.Pedidos3 ;;
  }

  dimension: pedidos4 {
    type: number
    sql: ${TABLE}.Pedidos4 ;;
  }

  dimension: pedidos_cancelados1 {
    type: number
    sql: ${TABLE}.pedidosCancelados1 ;;
  }

  dimension: pedidos_cancelados2 {
    type: number
    sql: ${TABLE}.pedidosCancelados2 ;;
  }

  dimension: pedidos_cancelados3 {
    type: number
    sql: ${TABLE}.pedidosCancelados3 ;;
  }

  dimension: pedidos_cancelados4 {
    type: number
    sql: ${TABLE}.pedidosCancelados4 ;;
  }

  dimension: porcentaje_cancelaciones1 {
    type: number
    value_format: "0\%"
    sql: ${TABLE}.perCancelaciones1 ;;
  }

  dimension: porcentaje_cancelaciones2 {
    type: number
    value_format: "0\%"
    sql: ${TABLE}.perCancelaciones2 ;;
  }

  dimension: porcentaje_cancelaciones3 {
    type: number
    value_format: "0\%"
    sql: ${TABLE}.perCancelaciones3 ;;
  }

  dimension: porcentaje_cancelaciones4 {
    type: number
    value_format: "0\%"
    sql: ${TABLE}.perCancelaciones4 ;;
  }

  dimension: piezas_encontradas1 {
    type: number
    sql: ${TABLE}.piezasEncontradas1 ;;
  }

  dimension: piezas_encontradas2 {
    type: number
    sql: ${TABLE}.piezasEncontradas2 ;;
  }

  dimension: piezas_encontradas3 {
    type: number
    sql: ${TABLE}.piezasEncontradas3 ;;
  }

  dimension: piezas_encontradas4 {
    type: number
    sql: ${TABLE}.piezasEncontradas4 ;;
  }

  dimension: piezas_encontradas_reemplazadas1 {
    type: number
    sql: ${TABLE}.piezasEncontradasReemplazadas1 ;;
  }

  dimension: piezas_encontradas_reemplazadas2 {
    type: number
    sql: ${TABLE}.piezasEncontradasReemplazadas2 ;;
  }

  dimension: piezas_encontradas_reemplazadas3 {
    type: number
    sql: ${TABLE}.piezasEncontradasReemplazadas3 ;;
  }

  dimension: piezas_encontradas_reemplazadas4 {
    type: number
    sql: ${TABLE}.piezasEncontradasReemplazadas4 ;;
  }

  dimension: piezas_pedidas1 {
    type: number
    sql: ${TABLE}.piezasPedidas1 ;;
  }

  dimension: piezas_pedidas2 {
    type: number
    sql: ${TABLE}.piezasPedidas2 ;;
  }

  dimension: piezas_pedidas3 {
    type: number
    sql: ${TABLE}.piezasPedidas3 ;;
  }

  dimension: piezas_pedidas4 {
    type: number
    sql: ${TABLE}.piezasPedidas4 ;;
  }

  dimension: semana1 {
    type: string
    sql: ${TABLE}.semana ;;
  }

  dimension: semana2 {
    type: string
    sql: ${TABLE}.semana2 ;;
  }

  dimension: semana3 {
    type: string
    sql: ${TABLE}.semana3 ;;
  }

  dimension: semana4 {
    type: string
    sql: ${TABLE}.semana4 ;;
  }

  dimension: ticket_promedio1 {
    type: number
    sql: ${TABLE}.ticketPromedio1 ;;
  }

  dimension: ticket_promedio2 {
    type: number
    sql: ${TABLE}.ticketPromedio2 ;;
  }

  dimension: ticket_promedio3 {
    type: number
    sql: ${TABLE}.ticketPromedio3 ;;
  }

  dimension: ticket_promedio4 {
    type: number
    sql: ${TABLE}.ticketPromedio4 ;;
  }

  dimension: total_clientes1 {
    type: number
    sql: ${TABLE}.totalClientes1 ;;
  }

  dimension: total_clientes2 {
    type: number
    sql: ${TABLE}.totalClientes2 ;;
  }

  dimension: total_clientes3 {
    type: number
    sql: ${TABLE}.totalClientes3 ;;
  }

  dimension: total_clientes4 {
    type: number
    sql: ${TABLE}.totalClientes4 ;;
  }

  dimension: ventas1 {
    type: number
    sql: ${TABLE}.ventas1 ;;
  }

  dimension: ventas2 {
    type: number
    sql: ${TABLE}.ventas2 ;;
  }

  dimension: ventas3 {
    type: number
    sql: ${TABLE}.ventas3 ;;
  }

  dimension: ventas4 {
    type: number
    sql: ${TABLE}.ventas4 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
