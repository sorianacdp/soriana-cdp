view: cdp_soriana_rfm_ltv {
  derived_table: {
    sql: select *
      from `costumer-data-proyect.customer_data_platform.cdp-soriana-RFM_LTV`
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: countdistinct {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
  }

  dimension: id_cliente_sk {
    type: string
    sql: ${TABLE}.IdClienteSk ;;
  }

  dimension: grcliente_id {
    type: string
    sql: ${TABLE}.GRClienteId ;;
  }

  dimension: id_tienda {
    type: string
    sql: ${TABLE}.IdTienda ;;
  }

  dimension: tienda {
    type: string
    sql: ${TABLE}.Tienda ;;
  }

  dimension: formato {
    type: string
    sql: ${TABLE}.Formato ;;
  }

  dimension: estado {
    type: string
    sql: ${TABLE}.Estado ;;
  }

  dimension: semana {
    type: string
    sql: ${TABLE}.semana ;;
  }

  dimension: semana_ultima_compra {
    type: string
    sql: ${TABLE}.SemanaUltimaCompra ;;
  }

  dimension: resta_semana {
    type: number
    sql: ${TABLE}.restaSemana ;;
  }

  dimension: hace_nsemanas {
    type: number
    sql: ${TABLE}.haceNSemanas ;;
  }

  dimension: anio_mes {
    type: string
    sql: ${TABLE}.AnioMes ;;
  }

  dimension: fecha_nacimiento_soriana {
    type: string
    sql: ${TABLE}.fechaNacimientoSoriana ;;
  }

  dimension: dias_de_vida {
    type: number
    sql: ${TABLE}.diasDeVida ;;
  }

  dimension: recencia {
    type: number
    sql: ${TABLE}.recencia ;;
  }

  dimension: fecha_ultima_compra {
    type: string
    sql: ${TABLE}.fechaUltimaCompra ;;
  }

  dimension: sexo {
    type: string
    sql: ${TABLE}.Sexo ;;
  }

  dimension: edad {
    type: number
    sql: ${TABLE}.Edad ;;
  }

  dimension: conteo_compras {
    type: number
    sql: ${TABLE}.conteoCompras ;;
  }

  dimension: ticket_promedio {
    type: number
    sql: ${TABLE}.ticketPromedio ;;
  }

  dimension: canal_exclusivo {
    type: string
    sql: ${TABLE}.canalExclusivo ;;
  }

  dimension: frecuenciade_compra {
    type: string
    sql: ${TABLE}.frecuenciadeCompra ;;
  }

  dimension: tipo_cliente {
    type: string
    sql: ${TABLE}.tipoCliente ;;
  }

  dimension: categoria_compra1 {
    type: string
    sql: ${TABLE}.categoriaCompra1 ;;
  }

  dimension: categoria_compra2 {
    type: string
    sql: ${TABLE}.categoriaCompra2 ;;
  }

  dimension: categoria_compra3 {
    type: string
    sql: ${TABLE}.categoriaCompra3 ;;
  }

  dimension: categoria_compra4 {
    type: string
    sql: ${TABLE}.categoriaCompra4 ;;
  }

  dimension: categoria_compra5 {
    type: string
    sql: ${TABLE}.categoriaCompra5 ;;
  }

  dimension: categoria_visto1 {
    type: string
    sql: ${TABLE}.categoriaVisto1 ;;
  }

  dimension: categoria_visto2 {
    type: string
    sql: ${TABLE}.categoriaVisto2 ;;
  }

  dimension: categoria_visto3 {
    type: string
    sql: ${TABLE}.categoriaVisto3 ;;
  }

  dimension: categoria_visto4 {
    type: string
    sql: ${TABLE}.categoriaVisto4 ;;
  }

  dimension: categoria_visto5 {
    type: string
    sql: ${TABLE}.categoriaVisto5 ;;
  }


  measure: clientePremium {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipo_cliente: "CLIENTE PREMIUM"]
  }

  measure: clienteValioso {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipo_cliente: "CLIENTE VALIOSO"]
  }

  measure: clientePotencial {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipo_cliente: "CLIENTE POTENCIAL"]
  }

  measure: clienteNoComprometido {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipo_cliente: "NO COMPROMETIDO"]
  }

  measure: clienteNuevo {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipo_cliente: "CLIENTE NUEVO"]
  }

  measure: clienteProspecto {
    type: count_distinct
    sql: ${TABLE}.IdClienteSk ;;
    filters: [tipo_cliente: "CLIENTE PROSPECTO"]
  }


  set: detail {
    fields: [
      id_cliente_sk,
      grcliente_id,
      id_tienda,
      tienda,
      formato,
      estado,
      semana,
      semana_ultima_compra,
      resta_semana,
      hace_nsemanas,
      anio_mes,
      fecha_nacimiento_soriana,
      dias_de_vida,
      recencia,
      fecha_ultima_compra,
      sexo,
      edad,
      conteo_compras,
      ticket_promedio,
      canal_exclusivo,
      frecuenciade_compra,
      tipo_cliente,
      categoria_compra1,
      categoria_compra2,
      categoria_compra3,
      categoria_compra4,
      categoria_compra5,
      categoria_visto1,
      categoria_visto2,
      categoria_visto3,
      categoria_visto4,
      categoria_visto5
    ]
  }
}
