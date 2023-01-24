view: googleads {
  derived_table: {
    sql: Select
      Date_diff(current_date,gcts.Week, week) HaceNSemana,
      sum(gcts.Clicks) as clicsGoogleAds,
      sum(gcts.CostPerConversion/1000000.0) as costoPorConversionGoogleAds,
      from
      `582216162585.google_ads.p_CampaignLocationTargetStats_5779242572` as gcts
      where CostPerConversion !=0.0
      group by 1
      order by 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  measure: TotalVentaGAds {
    type: sum
    sql: ${TABLE}.costoPorConversionGoogleAds;;
  }
  dimension: hace_nsemana {
    type: number
    sql: ${TABLE}.HaceNSemana ;;
  }

  dimension: clics_google_ads {
    type: number
    sql: ${TABLE}.clicsGoogleAds ;;
  }

  dimension: costo_por_conversion_google_ads {
    type: number
    sql: ${TABLE}.costoPorConversionGoogleAds ;;
  }

  set: detail {
    fields: [hace_nsemana, clics_google_ads, costo_por_conversion_google_ads]
  }
}
