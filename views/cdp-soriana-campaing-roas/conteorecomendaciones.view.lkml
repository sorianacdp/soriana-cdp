view: conteorecomendaciones {
  derived_table: {
    sql: with rango_fecha as (
      select
          format_date('%Y%m%d',date_sub(current_date(), interval 90 day)) as fecha_inicio,
          format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) as fecha_final
), dataset1 as (
Select
fechaCarga,
EXTRACT(year FROM fechaCarga) as anio,
EXTRACT(week FROM fechaCarga) semana,
"Despensa" as recomendaciones,
count(1) conteo
from `costumer-data-proyect.customer_data_platform.cdp-soriana-audicencia-recomendaciones-Des-Lim-frut-car-pes`, rango_fecha
where fechaCarga between  PARSE_DATE("%Y%m%d",fecha_inicio) and  PARSE_DATE("%Y%m%d",fecha_final)
group by 1,2,fechaCarga

      UNION ALL
      Select
      fechaCarga,
      EXTRACT(year FROM fechaCarga) as anio,
      EXTRACT(week FROM fechaCarga) semana,
      "Bebés" as recomendaciones,
      count(1) conteo
      from `costumer-data-proyect.customer_data_platform.cdp-soriana-audicencia-recomendaciones-bebes`, rango_fecha
      where fechaCarga between  PARSE_DATE("%Y%m%d",fecha_inicio) and  PARSE_DATE("%Y%m%d",fecha_final)
      group by 1,2,fechaCarga

      UNION ALL
      Select
      fechaCarga,
      EXTRACT(year FROM fechaCarga) as anio,
      EXTRACT(week FROM fechaCarga) semana,
      "Belleza" as recomendaciones,
      count(1) conteo
      from `costumer-data-proyect.customer_data_platform.cdp-soriana-audicencia-recomendaciones-belleza`, rango_fecha
      where fechaCarga between  PARSE_DATE("%Y%m%d",fecha_inicio) and  PARSE_DATE("%Y%m%d",fecha_final)
      group by 1,2,fechaCarga

      UNION ALL
      Select
      fechaCarga,
      EXTRACT(year FROM fechaCarga) as anio,
      EXTRACT(week FROM fechaCarga) semana,
      "Electronica" as recomendaciones,
      count(1) conteo
      from `costumer-data-proyect.customer_data_platform.cdp-soriana-audicencia-recomendaciones-electronica`, rango_fecha
      where fechaCarga between  PARSE_DATE("%Y%m%d",fecha_inicio) and  PARSE_DATE("%Y%m%d",fecha_final)
      group by 1,2,fechaCarga

      UNION ALL
      Select
      fechaCarga,
      EXTRACT(year FROM fechaCarga) as anio,
      EXTRACT(week FROM fechaCarga) semana,
      "Jugueteria" as recomendaciones,
      count(1) conteo
      from `costumer-data-proyect.customer_data_platform.cdp-soriana-audicencia-recomendaciones-jugueteria`, rango_fecha
      where fechaCarga between  PARSE_DATE("%Y%m%d",fecha_inicio) and  PARSE_DATE("%Y%m%d",fecha_final)
      group by 1,2,fechaCarga

      UNION ALL
      Select
      fechaCarga,
      EXTRACT(year FROM fechaCarga) as anio,
      EXTRACT(week FROM fechaCarga) semana,
      "Mascotas" as recomendaciones,
      count(1) conteo
      from `costumer-data-proyect.customer_data_platform.cdp-soriana-audicencia-recomendaciones-mascotas`, rango_fecha
      where fechaCarga between  PARSE_DATE("%Y%m%d",fecha_inicio) and  PARSE_DATE("%Y%m%d",fecha_final)
      group by 1,2,fechaCarga

      UNION ALL
      Select
      fechaCarga,
      EXTRACT(year FROM fechaCarga) as anio,
      EXTRACT(week FROM fechaCarga) semana,
      "Vinos Licores" as recomendaciones,
      count(1) conteo
      from `costumer-data-proyect.customer_data_platform.cdp-soriana-audicencia-recomendaciones-vinos-licores`, rango_fecha
      where fechaCarga between  PARSE_DATE("%Y%m%d",fecha_inicio) and  PARSE_DATE("%Y%m%d",fecha_final)
      group by 1,2,fechaCarga
      )
      Select * from dataset1 order by 1 asc
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: fecha_carga {
    type: date
    datatype: date
    sql: ${TABLE}.fechaCarga ;;
  }

  dimension: anio {
    type: number
    sql: ${TABLE}.anio ;;
  }

  dimension: semana {
    type: number
    sql: ${TABLE}.semana ;;
  }

  dimension: recomendaciones {
    type: string
    sql: ${TABLE}.recomendaciones ;;
  }

  dimension: conteo {
    type: number
    sql: ${TABLE}.conteo ;;
  }

  set: detail {
    fields: [fecha_carga, anio, semana, recomendaciones, conteo]
  }
}
