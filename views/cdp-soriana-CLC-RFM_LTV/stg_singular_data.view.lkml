view: stg_singular_data {
  sql_table_name: `costumer-data-proyect.STG_data.STG_singular_data`
    ;;

  dimension: advertising_id {
    type: string
    sql: ${TABLE}.advertising_id ;;
  }

  dimension_group: attribution_event_timestamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.attribution_event_timestamp ;;
  }

  dimension: basket_size {
    type: number
    sql: ${TABLE}.basket_size ;;
  }

  dimension: campana_primera_compra {
    type: string
    sql: ${TABLE}.campana_primera_compra ;;
  }

  dimension: categorias_mas_compradas {
    type: string
    sql: ${TABLE}.categorias_mas_compradas ;;
  }

  dimension: custom_user_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.custom_user_id ;;
  }

  dimension: dias_entre_compra_instalacion {
    type: number
    sql: ${TABLE}.dias_entre_compra_instalacion ;;
  }

  dimension: estado {
    type: string
    sql: ${TABLE}.estado ;;
  }

  dimension_group: fecha_orden {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: datetime
    sql: ${TABLE}.fecha_orden ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }

  dimension: order_id_primera_compra {
    type: string
    sql: ${TABLE}.order_id_primera_compra ;;
  }

  dimension: partner_primera_compra {
    type: string
    sql: ${TABLE}.partner_primera_compra ;;
  }

  dimension: revenue_compras_totales {
    type: number
    sql: ${TABLE}.revenue_compras_totales ;;
  }

  dimension: revenue_primera_compra {
    type: number
    sql: ${TABLE}.revenue_primera_compra ;;
  }

  dimension: sub_campaign_name {
    type: string
    sql: ${TABLE}.sub_campaign_name ;;
  }

  dimension: total_ordenes {
    type: number
    sql: ${TABLE}.total_ordenes ;;
  }

  measure: count {
    type: count
    drill_fields: [sub_campaign_name]
  }
}
