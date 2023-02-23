view: cdp_soriana_medio_fuente_origen {
  derived_table: {
    sql: select * from `costumer-data-proyect.customer_data_platform.cdp-soriana-media-fuente-origen`
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  dimension: esta_logueado{
    type: string
    sql: ${TABLE}.estaLogueado ;;
  }
  dimension: fecha_primera_compra{
    type: string
    sql: ${TABLE}.fechaPrimeraCompra ;;
  }

  dimension: fecha_ultima_compra{
    type: string
    sql: ${TABLE}.fechaUltimaCompra ;;
  }

  dimension: GRClienteId{
    type: string
    sql: ${TABLE}.GRClienteId ;;
  }

  dimension: plataforma{
    type: string
    sql: ${TABLE}.plataforma ;;
  }

  dimension: usuario_logueado_origin {
    type: string
    sql: ${TABLE}.usuarioLogueadoOrigin ;;
  }

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertisingId ;;
  }

  dimension: media_source_origen {
    type: string
    sql: ${TABLE}.mediaSourceOrigen ;;
  }

  dimension: nombre_campaign{
    type: string
    sql: ${TABLE}.nombreCampaign ;;
  }

  dimension: id_transaccion_primera_compra {
    type: string
    sql: ${TABLE}.idTransaccionPrimeraCompra ;;
  }

  dimension: revenue_primera_compra {
    type: number
    sql: ${TABLE}.revenuePrimeraCompra ;;
  }

  dimension: conteo_compras {
    type: number
    sql: ${TABLE}.ConteoCompras ;;
  }

  dimension: revenue_compras_totales {
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.revenueComprasTotales ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.firstName ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.lastName ;;
  }

  dimension: phone_mobile {
    type: string
    sql: ${TABLE}.phoneMobile ;;
  }

  dimension: dias_de_vida {
    type: number
    sql: ${TABLE}.dias_de_vida ;;
  }

  dimension: dias_sin_compra {
    type: number
    sql: ${TABLE}.dias_sin_compra ;;
  }
  dimension: ticket_promedio {
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.ticket_promedio ;;
  }
  dimension: instalaciones_aplicacion {
    type: number
    sql: ${TABLE}.instalacionesAplicacion ;;
  }

  dimension: desinstalaciones_aplicacion {
    type: number
    sql: ${TABLE}.desinstalacionesAplicacion ;;
  }

  dimension: compras_8semanas {
    type: number
    sql: ${TABLE}.compras_8semanas ;;
  }
  dimension: revenue_8semanas {
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.revenue_8semanas ;;
  }
  dimension: ticket_promedio_8semanas {
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.ticket_promedio_8semanas ;;
  }
  dimension: semanas_con_compras_8semanas {
    type: number
    sql: ${TABLE}.semanas_con_compras_8semanas ;;
  }
  dimension: frecuencia_8semanas {
    type: number
    value_format: "#,##0.00"
    sql: ${TABLE}.frecuencia_8semanas ;;
  }
  dimension: rango_frecuencia_8semanas {
    type: string
    sql: ${TABLE}.rango_frecuencia_8semanas ;;
  }
  dimension: bucket {
    type: string
    sql: ${TABLE}.bucket ;;
  }

  set: detail {
    fields: [
      esta_logueado,
      fecha_primera_compra,
      fecha_ultima_compra,
      plataforma,
      usuario_logueado_origin,
      advertising_id,
      media_source_origen,
      nombre_campaign,
      id_transaccion_primera_compra,
      revenue_primera_compra,
      conteo_compras,
      revenue_compras_totales,
      email,
      first_name,
      last_name,
      phone_mobile,
      instalaciones_aplicacion,
      desinstalaciones_aplicacion,

      dias_de_vida,
      dias_sin_compra,
      ticket_promedio,

      compras_8semanas,
      revenue_8semanas,
      ticket_promedio_8semanas,
      semanas_con_compras_8semanas,
      frecuencia_8semanas,
      rango_frecuencia_8semanas,
      bucket
    ]
  }
}
