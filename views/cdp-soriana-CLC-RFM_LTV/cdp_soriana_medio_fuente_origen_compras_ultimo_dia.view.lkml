view: cdp_soriana_medio_fuente_origen_compras_ultimo_dia {
  derived_table: {
    sql: select * from `costumer-data-proyect.customer_data_platform.cdp-soriana-media-fuente-origen-compras-ultimo-dia`
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
  dimension: advertising_id{
    type: string
    sql: ${TABLE}.advertisingId ;;
  }
  dimension: usuario_logueado_origin{
    type: string
    sql: ${TABLE}.usuarioLogueadoOrigin ;;
  }
  dimension: media_source_origen{
    type: string
    sql: ${TABLE}.mediaSourceOrigen ;;
  }
  dimension: nombre_campaign {
    type: string
    sql: ${TABLE}.nombreCampaign ;;
  }
  dimension: fecha_orden {
    type: date
    datatype: date
    sql: ${TABLE}.fechaOrden ;;
  }
  dimension: id_transaccion {
    type: string
    sql: ${TABLE}.idTransaccion ;;
  }
  dimension: total_compra {
    type: string
    sql: ${TABLE}.totalCompra ;;
  }
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }
  dimension: fecha_primera_compra_historica {
    type: string
    sql: ${TABLE}.fechaPrimeraCompraHistorica ;;
  }
  dimension: nombre_campana_primera_compra_historica {
    type: string
    sql: ${TABLE}.nombreCampanaPrimeraCompraHistorica ;;
  }
  dimension: media_origen_primera_compra_historica {
    type: string
    sql: ${TABLE}.mediaOrigenPrimeraCompraHistorica ;;
  }
  dimension: id_transaccion_primera_compra_historica {
    type: string
    sql: ${TABLE}.idTransaccionPrimeraCompraHistorica ;;
  }
  dimension: fecha_ultima_compra_historica {
    type: string
    sql: ${TABLE}.fechaUltimaCompraHistorica ;;
  }
  dimension: nombre_campana_ultima_compra_historica {
    type: string
    sql: ${TABLE}.nombreCampanaUltimaCompraHistorica ;;
  }
  dimension: media_origen_ultima_compra_historica {
    type: string
    sql: ${TABLE}.mediaOrigenUltimaCompraHistorica ;;
  }
  dimension: id_transaccion_ultima_compra_historica {
    type: string
    sql: ${TABLE}.idTransaccionUltimaCompraHistorica ;;
  }
  dimension: conteo_compras_totales_historica {
    type: string
    sql: ${TABLE}.conteoComprasTotalesHistorica ;;
  }
  dimension: revenue_compras_totales_historica {
    type: string
    sql: ${TABLE}.revenueComprasTotalesHistorica ;;
  }



  set: detail {
    fields: [
      esta_logueado,
      email,
      usuario_logueado_origin,
      advertising_id,
      media_source_origen,
      nombre_campaign,
      fecha_orden,
      total_compra,
      fecha_primera_compra_historica,
      nombre_campana_primera_compra_historica,
      media_origen_primera_compra_historica,
      id_transaccion_primera_compra_historica,
      fecha_ultima_compra_historica,
      nombre_campana_ultima_compra_historica,
      media_origen_ultima_compra_historica,
      id_transaccion_ultima_compra_historica,
      conteo_compras_totales_historica,
      revenue_compras_totales_historica
    ]
  }
}
