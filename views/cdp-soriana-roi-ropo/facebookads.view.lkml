view: facebookads {
  derived_table: {
    sql: WITH dataset as (
      SELECT
      dateStart,
      dateStop,
      sum(cast(clicks as float64)) totalClicksFacebook,
      sum(cast(costPerConversionValue as float64)) totalCostoCampaniasFacebook,
      FROM `costumer-data-proyect.facebook_ads.stg_facebookAdsCampaign`
      where costPerConversionValue !="N/A"
        AND cast(dateStart as datetime) > date_sub(current_date(), interval 90 day)
      group by 1,2
      order by dateStart
       )
       ,dataset2 as (
      SELECT
       dateStart,
       EXTRACT(week from cast(dateStart as datetime)) SemanaInicio,
       dateStop,
       EXTRACT(week from cast(dateStop as datetime)) SemanaFin,
       totalClicksFacebook,
       totalCostoCampaniasFacebook
      FROM dataset
       )
       SELECT
       --dateStart,
       Extract(week from current_date)-SemanaInicio as HaceNSemanaInicio,
       Extract(week from current_date)-SemanaFin as HaceNSemanaFinal,
       sum(totalClicksFacebook) totalClicksFacebook,
       sum(totalCostoCampaniasFacebook) totalCostoCampaniasFacebook
       FROM dataset2
       group by 1,2
       order by 1,2
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: CostoPromedio {
    type: average
    sql: ${TABLE}.ingresoTotal;;
  }

  dimension: hace_nsemana_inicio {
    type: number
    sql: ${TABLE}.HaceNSemanaInicio ;;
  }

  dimension: hace_nsemana_final {
    type: number
    sql: ${TABLE}.HaceNSemanaFinal ;;
  }

  dimension: total_clicks_facebook {
    type: number
    sql: ${TABLE}.totalClicksFacebook ;;
  }

  dimension: total_costo_campanias_facebook {
    type: number
    sql: ${TABLE}.totalCostoCampaniasFacebook ;;
  }

  set: detail {
    fields: [hace_nsemana_inicio, hace_nsemana_final, total_clicks_facebook, total_costo_campanias_facebook]
  }
}
