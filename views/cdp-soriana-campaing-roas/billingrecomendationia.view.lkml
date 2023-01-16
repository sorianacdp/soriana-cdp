view: billingrecomendationia {
  derived_table: {
    sql: SELECT
      invoice.month,
      service.description,
      usage_start_time,
      usage_end_time,
      project.ancestors[SAFE_OFFSET(0)].display_name,
      cost * 18.92 costo,
      --currency_conversion_rate,
      --usage.amount
      FROM `costumer-data-proyect.billing_id_soriana.gcp_billing_export_resource_v1_018895_90C7CD_6A437D`
      WHERE service.description  in ("Vertex AI", "Recommendations AI") and
      project.ancestors[SAFE_OFFSET(0)].display_name ="Customer Data Platform"
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: month {
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension_group: usage_start_time {
    type: time
    sql: ${TABLE}.usage_start_time ;;
  }

  dimension_group: usage_end_time {
    type: time
    sql: ${TABLE}.usage_end_time ;;
  }

  dimension: display_name {
    type: string
    sql: ${TABLE}.display_name ;;
  }

  dimension: costo {
    type: number
    sql: ${TABLE}.costo ;;
  }

  set: detail {
    fields: [
      month,
      description,
      usage_start_time_time,
      usage_end_time_time,
      display_name,
      costo
    ]
  }
}
