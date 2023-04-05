view: stg_singular_events {
  sql_table_name: `costumer-data-proyect.STG_data.STG_singular_events`
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

  dimension: campana_primera_compra {
    type: string
    sql: ${TABLE}.campana_primera_compra ;;
  }

  dimension: campana_ultima_compra {
    type: string
    sql: ${TABLE}.campana_ultima_compra ;;
  }

  dimension: custom_user_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.custom_user_id ;;
  }

  dimension: desinstalaciones_app {
    type: number
    sql: ${TABLE}.desinstalaciones_app ;;
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

  dimension_group: fecha_primera_compra {
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
    sql: ${TABLE}.fecha_primera_compra ;;
  }

  dimension_group: fecha_ultima_compra {
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
    sql: ${TABLE}.fecha_ultima_compra ;;
  }

  dimension: id_transaccion {
    type: string
    sql: ${TABLE}.id_transaccion ;;
  }

  dimension: instalaciones_app {
    type: number
    sql: ${TABLE}.instalaciones_app ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }

  dimension: partner_primera_compra {
    type: string
    sql: ${TABLE}.partner_primera_compra ;;
  }

  dimension: plataforma_primera_compra {
    type: string
    sql: ${TABLE}.plataforma_primera_compra ;;
  }

  dimension: productos_comprados {
    type: number
    sql: ${TABLE}.productos_comprados ;;
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
