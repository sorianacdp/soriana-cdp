view: campanavistas {
  derived_table: {
    sql: with rango_fecha as (
      select
          format_date('%Y%m%d',date_sub(current_date(), interval 90 day)) as fecha_inicio,
          format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) as fecha_final
)
SELECT
PARSE_DATE("%Y%m%d",event_date) as fecha,
EXTRACT(year FROM PARSE_DATE("%Y%m%d",event_date)) as anio,
EXTRACT(week FROM PARSE_DATE("%Y%m%d",event_date)) semana,
event_name,
platform as plataforma,
ifnull(user_id,'(not set)') as usuarioLogueado,
ifnull(geo.region,'(not set)') as geoRegion,
ifnull(geo.city,'(not set)') as geonCity,
ifnull(traffic_source.medium,'(not set)') as medio,
ifnull(traffic_source.source,'(not set)') as fuente,
ifnull(traffic_source.name,'(not set)') as nombreCampana,
FROM `costumer-data-proyect.analytics_249184604.events_*`,rango_fecha
WHERE
-- and user_id != '(not set)'
traffic_source.medium = 'email'
and (ecommerce.transaction_id = '(not set)' or event_name in  ('page_view','view_item','view_search_results','view_promotion') )
and traffic_source.name like '%recomendacionescdp%'
and PARSE_DATE("%Y%m%d",event_date) between  PARSE_DATE("%Y%m%d",fecha_inicio) and  PARSE_DATE("%Y%m%d",fecha_final)
--GROUP BY 1,2,3,4,5,6,7,8,9,10
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: fecha {
    type: date
    datatype: date
    sql: ${TABLE}.fecha ;;
  }

  dimension: anio {
    type: number
    sql: ${TABLE}.anio ;;
  }

  dimension: semana {
    type: number
    sql: ${TABLE}.semana ;;
  }

  dimension: event_name {
    type: string
    sql: ${TABLE}.event_name ;;
  }

  dimension: plataforma {
    type: string
    sql: ${TABLE}.plataforma ;;
  }

  dimension: usuario_logueado {
    type: string
    sql: ${TABLE}.usuarioLogueado ;;
  }

  dimension: geo_region {
    type: string
    sql: ${TABLE}.geoRegion ;;
  }

  dimension: geon_city {
    type: string
    sql: ${TABLE}.geonCity ;;
  }

  dimension: medio {
    type: string
    sql: ${TABLE}.medio ;;
  }

  dimension: fuente {
    type: string
    sql: ${TABLE}.fuente ;;
  }

  dimension: nombre_campana {
    type: string
    sql: ${TABLE}.nombreCampana ;;
  }

  set: detail {
    fields: [
      fecha,
      anio,
      semana,
      event_name,
      plataforma,
      usuario_logueado,
      geo_region,
      geon_city,
      medio,
      fuente,
      nombre_campana
    ]
  }
}
