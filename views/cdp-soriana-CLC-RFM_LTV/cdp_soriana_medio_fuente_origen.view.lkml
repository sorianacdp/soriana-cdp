view: cdp_soriana_medio_fuente_origen {
  derived_table: {
    sql: select * from `costumer-data-proyect.customer_data_platform.cdp-soriana-media-fuente-origen`
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
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
    sql: ${TABLE}.advertising_id ;;
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

  set: detail {
    fields: [
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
      phone_mobile
    ]
  }
}
