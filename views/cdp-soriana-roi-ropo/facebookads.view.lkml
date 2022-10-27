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
), dataset3 as(
SELECT
  Extract(week from current_date)-SemanaFin as HaceNSemanaInicio,
  sum(totalClicksFacebook) totalClicksFacebook,
  (sum(totalCostoCampaniasFacebook) / Extract(week from current_date)-SemanaInicio)  totalCostoCampaniasFacebook,
FROM dataset2
--where Extract(week from current_date)-SemanaFin != Extract(week from current_date)-SemanaInicio
group by 1, SemanaInicio
order by 1
)
select
HaceNSemanaInicio as HaceNSemana,
AVG(totalClicksFacebook) as totalClicksFacebook,
AVG(totalCostoCampaniasFacebook) as totalCostoCampaniasFacebook
from dataset3
group by 1
order by HaceNSemanaInicio
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: CostoPromedio {
    type: sum
    sql: ${TABLE}.totalCostoCampaniasFacebook;;
  }

  dimension: hace_nsemana {
    type: number
    sql: ${TABLE}.HaceNSemana ;;
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
    fields: [hace_nsemana, total_clicks_facebook, total_costo_campanias_facebook]
  }
}
