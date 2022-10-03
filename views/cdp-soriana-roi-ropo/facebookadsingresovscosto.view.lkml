view: facebookadsingresovscosto {
  derived_table: {
    sql: Select p.HaceNsemanas, sum(p.ingresoTotal) as TotalVentaFADS, facebookads.totalCostoCampaniasFacebook  From ${cdpusuario__articulos__ga_gads_fads_purchase.SQL_TABLE_NAME} p, ${facebookads.SQL_TABLE_NAME}
      where p.HaceNsemanas = facebookads.HaceNSemana AND p.nombreCampanaGoogleAds ="(not set)"  AND p.nombreCampanaFacebookAds !="(not set)"
      group by 1,3
      order by p.HaceNsemanas asc
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: costo {
    type: sum
    sql: ${TABLE}.totalCostoCampaniasFacebook;;
  }

  measure: venta {
    type: sum
    sql: ${TABLE}.TotalVentaFADS;;
  }

  dimension: hace_nsemanas {
    type: number
    sql: ${TABLE}.HaceNsemanas ;;
  }

  dimension: total_venta_fads {
    type: number
    sql: ${TABLE}.TotalVentaFADS ;;
  }

  dimension: total_costo_campanias_facebook {
    type: number
    sql: ${TABLE}.totalCostoCampaniasFacebook ;;
  }

  set: detail {
    fields: [hace_nsemanas, total_venta_fads, total_costo_campanias_facebook]
  }
}
