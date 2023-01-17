view: topcategoriamercurio {
  derived_table: {
    sql: SELECT * FROM `costumer-data-proyect.customer_data_platform. cdp-soriana-mercurio-topCategorias-compradas`
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: customer_email {
    type: string
    sql: ${TABLE}.customerEmail ;;
  }

  dimension: top_categoria_ga1 {
    type: string
    sql: ${TABLE}.topCategoriaGA1 ;;
  }

  dimension: top_categoria_ga2 {
    type: string
    sql: ${TABLE}.topCategoriaGA2 ;;
  }

  dimension: top_categoria_ga3 {
    type: string
    sql: ${TABLE}.topCategoriaGA3 ;;
  }

  dimension: top_categoria_ga4 {
    type: string
    sql: ${TABLE}.topCategoriaGA4 ;;
  }

  dimension: top_categoria_ga5 {
    type: string
    sql: ${TABLE}.topCategoriaGA5 ;;
  }

  set: detail {
    fields: [
      customer_email,
      top_categoria_ga1,
      top_categoria_ga2,
      top_categoria_ga3,
      top_categoria_ga4,
      top_categoria_ga5
    ]
  }
}
