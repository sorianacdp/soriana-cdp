view: costosretail {
  derived_table: {
    sql: Select round((sum(conteo) * 0.00015) * 18.92, 2) as Costo ,"costo Envio" tipo from ${conteorecomendaciones.SQL_TABLE_NAME}
      UNION ALL
      Select round(sum(costo),2) as Costo , "costo GCP" tipo from ${billingrecomendationia.SQL_TABLE_NAME}
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
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
