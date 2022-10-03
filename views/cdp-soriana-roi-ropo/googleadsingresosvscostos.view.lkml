view: googleadsingresosvscostos {
  derived_table: {
    sql: Select p.HaceNsemanas, sum(p.ingresoTotal) as TotalVentaGADS, googleads.costoPorConversionGoogleAds From ${cdpusuario__articulos__ga_gads_fads_purchase.SQL_TABLE_NAME} p,  ${googleads.SQL_TABLE_NAME}
      where p.HaceNsemanas = googleads.HaceNSemana AND p.nombreCampanaGoogleAds !="(not set)"  AND p.nombreCampanaFacebookAds ="(not set)"
      group by 1,3
      order by p.HaceNsemanas asc
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: hace_nsemanas {
    type: number
    sql: ${TABLE}.HaceNsemanas ;;
  }

  dimension: total_venta_gads {
    type: number
    sql: ${TABLE}.TotalVentaGADS ;;
  }

  dimension: costo_por_conversion_google_ads {
    type: number
    sql: ${TABLE}.costoPorConversionGoogleAds ;;
  }

  set: detail {
    fields: [hace_nsemanas,costo_por_conversion_google_ads,total_venta_gads]
  }
}
