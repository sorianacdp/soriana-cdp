view: campaing_email {
  derived_table: {
    sql: SELECT
      PARSE_DATE("%Y%m%d",event_date) as fecha,
      event_name,
      platform as plataforma,
      ifnull(user_id,'(not set)') as usuarioLogueado,
      ifnull(geo.region,'(not set)') as geoRegion,
      ifnull(geo.city,'(not set)') as geonCity,
      ifnull(ecommerce.transaction_id,'(not set)') as idTransaccion,
      ifnull(traffic_source.medium,'(not set)') as medio,
      ifnull(traffic_source.source,'(not set)') as fuente,
      ifnull(traffic_source.name,'(not set)') as nombreCampana,
      ecommerce.purchase_revenue as ingreso,
      FROM `costumer-data-proyect.analytics_249184604.events_*`
      WHERE
      -- and user_id != '(not set)'
      traffic_source.medium = 'email'
      and (ecommerce.transaction_id != '(not set)' or event_name = 'purchase')
      --and traffic_source.source = 'sfmc'
      --and traffic_source.name like '%sfmc_performance_web_email_conversion_general_%'
      --GROUP BY 1,2,3,4,5,6,7,8,9,10
       ;;
  }

  measure: sumaGastoAcumulado{
    type: sum
    sql: ${TABLE}.ingreso ;;
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

  dimension: id_transaccion {
    type: string
    sql: ${TABLE}.idTransaccion ;;
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

  dimension: ingreso {
    type: number
    sql: ${TABLE}.ingreso ;;
  }

  set: detail {
    fields: [
      fecha,
      event_name,
      plataforma,
      usuario_logueado,
      geo_region,
      geon_city,
      id_transaccion,
      medio,
      fuente,
      nombre_campana,
      ingreso
    ]
  }
}
