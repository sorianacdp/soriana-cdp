view: costosretail {
  derived_table: {
    sql: Select fechaCarga as fecha, round((sum(conteo) * 0.00015) * 18.92, 2) as Costo ,"costo Envio" tipo from ${conteorecomendaciones.SQL_TABLE_NAME}
group by 1
UNION ALL
Select CAST(usage_start_time as date) as fecha, round(sum(costo),2) as Costo , "costo GCP" tipo from ${billingrecomendationia.SQL_TABLE_NAME}
group by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: suma_conteo {
    type: sum
    sql: ${TABLE}.Costo;;

  }

  dimension: fecha {
    type: date
    datatype: date
    sql: ${TABLE}.fecha ;;
  }

  dimension: costo {
    type: number
    sql: ${TABLE}.Costo ;;
  }

  dimension: tipo {
    type: string
    sql: ${TABLE}.tipo ;;
  }

  set: detail {
    fields: [costo, tipo]
  }
}
