view: roas {
  derived_table: {
    sql: WITH conteorecomendaciones AS (with rango_fecha as (
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
      )
      ,  billingrecomendationia AS (SELECT
      invoice.month,
      service.description,
      usage_start_time,
      usage_end_time,
      project.ancestors[SAFE_OFFSET(0)].display_name,
      cost * 18.92 costo,
      --currency_conversion_rate,
      --usage.amount
      FROM `costumer-data-proyect.billing_id_soriana.gcp_billing_export_resource_v1_018895_90C7CD_6A437D`
      WHERE service.description  in ("Vertex AI", "Recommendations AI") and
      project.ancestors[SAFE_OFFSET(0)].display_name ="Customer Data Platform"
      )
      ,  costosretail AS (Select fechaCarga as fecha, round((sum(conteo) * 0.00015) * 18.92, 2) as Costo ,"costo Envio" tipo from conteorecomendaciones
      group by 1
      UNION ALL
      Select CAST(usage_start_time as date) as fecha, round(sum(costo),2) as Costo , "costo GCP" tipo from billingrecomendationia
      group by 1
      ),

      camapaingreso AS (with rango_fecha as (
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
      cp.GRClienteId,
      cp.correo,
      ifnull(geo.region,'(not set)') as geoRegion,
      ifnull(geo.city,'(not set)') as geonCity,
      ifnull(ecommerce.transaction_id,'(not set)') as idTransaccion,
      ifnull(traffic_source.medium,'(not set)') as medio,
      ifnull(traffic_source.source,'(not set)') as fuente,
      ifnull(traffic_source.name,'(not set)') as nombreCampana,
      ecommerce.purchase_revenue as ingreso,
      FROM `costumer-data-proyect.analytics_249184604.events_*` ga, rango_fecha
      inner join `customer_data_platform.cdp_synapse_universo_clientes_productivos` cp
      ON ga.user_id = cp.GAUserId
      WHERE
      -- and user_id != '(not set)'
      traffic_source.medium = 'email'
      and (ecommerce.transaction_id != '(not set)' or event_name = 'purchase')
      and traffic_source.name like '%recomendacionescdp%'
      and PARSE_DATE("%Y%m%d",event_date) between  PARSE_DATE("%Y%m%d",fecha_inicio) and  PARSE_DATE("%Y%m%d",fecha_final)
      --GROUP BY 1,2,3,4,5,6,7,8,9,10
      )
      Select
      c.fecha,
      sum(Costo) costo,
      sum(ingreso) ingreso,
      round(sum(ingreso) / sum(Costo),2) as roas
      from costosretail c
      inner join camapaingreso i
      on c.fecha = i.fecha
      group by 1
      limit 10
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

  dimension: costo {
    type: number
    sql: ${TABLE}.costo ;;
  }

  dimension: ingreso {
    type: number
    sql: ${TABLE}.ingreso ;;
  }

  dimension: roas {
    type: number
    sql: ${TABLE}.roas ;;
  }

  set: detail {
    fields: [fecha, costo, ingreso, roas]
  }
}
