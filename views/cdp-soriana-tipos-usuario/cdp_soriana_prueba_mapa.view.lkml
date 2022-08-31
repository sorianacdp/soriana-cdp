view: cdp_soriana_prueba_mapa {
  derived_table: {
    sql: -- GA4 app Soriana Adquisicion de usuarios, dividido en fecha, plataforma, user_id(identificado), user_pseudo_id(no identificado), transacction id
      ---informacion articulos con compra
      with rango_fecha as (
      select
          --format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) as fecha_inicio,
          '20220706' as fecha_inicio,
          format_date('%Y%m%d',date_sub(current_date(), interval 1 day)) as fecha_final),
      prep as (
      select
      ###Dimensiones
          PARSE_DATE("%Y%m%d",event_date) as fecha,
          platform as plataforma,
          ifnull(user_id,'(not set)') as usuarioLogueado,
          ifnull(user_pseudo_id,'(not set)') as usuarioNoLogueado,
          (select value.int_value from unnest(event_params) where key = 'ga_session_id') as idSesion,
          TIMESTAMP_MICROS(user_first_touch_timestamp) as tiempoSesion,
          ifnull(traffic_source.medium,'(not set)') as medio,
          ifnull(traffic_source.source,'(not set)') as fuente,
          ifnull(trim(device.category),'(not set)') as categoriaDispositivo,
          ifnull(trim(device.mobile_brand_name),'(not set)') as marcaDispositivo,
          ifnull(trim(device.operating_system),'(not set)') as sistemaOperativo,
          ifnull(trim(device.mobile_marketing_name),'(not set)') as modelo,
          case
          when geo.region='' then '(not set)'
          when geo.region is null then '(not set)'
          else geo.region
          end as estado,
          case
          when geo.city='' then '(not set)'
          when geo.city is null then '(not set)'
          else geo.city
          end as ciudad,
          case
          when geo.country='' then '(not set)'
          when geo.country is null then '(not set)'
          else geo.country
          end as pais,

      from
      `costumer-data-proyect.analytics_249184604.events_*`,rango_fecha
      where
      --_table_suffix between '20220706' and format_date('%Y%m%d',date_sub(current_date(), interval 1 day))
      _table_suffix between rango_fecha.fecha_inicio and rango_fecha.fecha_final and ecommerce.transaction_id is null and user_id is not null
      group by 1,2,3,4,5,6,7,8,8,9,10,11,12,13,14,15)

      ---------------------------------------------
      -- main query
      select
###GA4
      --fecha
      distinct fecha,
      --plataforma
      plataforma,
      --usuario identificado
      usuarioLogueado,
      --usuario no identificado
      usuarioNoLogueado,
      ## sesion ID
      ifnull(idSesion,0) as idSesion,
      #tiempo de la sesion
      --tiempoSesion,
      tiempoSesion as tiempoSesion,
      --TIMESTAMP_MILLIS(tiempoSesion) as tiempoSesion,
      ###medio fuente
      concat(fuente,' / ',medio) as fuenteMedioUsuario,
      #categoria dispositivo
      categoriaDispositivo,
      #marca dispositivo
      marcaDispositivo,
      #sistema dispositivo
      sistemaOperativo,
      #modelo
      modelo,
      #estado
      estado,
      #ciudad
      ciudad,
      #pais
      pais,
      from
      prep
      --where plataforma='WEB'
      group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14
      order by
      plataforma asc,fecha desc, usuarioLogueado
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

  dimension: plataforma {
    type: string
    sql: ${TABLE}.plataforma ;;
  }

  dimension: usuario_logueado {
    type: string
    sql: ${TABLE}.usuarioLogueado ;;
  }

  dimension: usuario_no_logueado {
    type: string
    sql: ${TABLE}.usuarioNoLogueado ;;
  }

  dimension: id_sesion {
    type: number
    sql: ${TABLE}.idSesion ;;
  }

  dimension_group: tiempo_sesion {
    type: time
    sql: ${TABLE}.tiempoSesion ;;
  }

  dimension: fuente_medio_usuario {
    type: string
    sql: ${TABLE}.fuenteMedioUsuario ;;
  }

  dimension: categoria_dispositivo {
    type: string
    sql: ${TABLE}.categoriaDispositivo ;;
  }

  dimension: marca_dispositivo {
    type: string
    sql: ${TABLE}.marcaDispositivo ;;
  }

  dimension: sistema_operativo {
    type: string
    sql: ${TABLE}.sistemaOperativo ;;
  }

  dimension: modelo {
    type: string
    sql: ${TABLE}.modelo ;;
  }

  dimension: estado {
    type: string
    sql: ${TABLE}.estado ;;
  }

  dimension: ciudad {
    type: string
    sql: ${TABLE}.ciudad ;;
  }

  dimension: pais {
    type: string
    sql: ${TABLE}.pais ;;
  }


  dimension: estados {
    map_layer_name: mexico
    sql: ${TABLE}.estado ;;
  }

  set: detail {
    fields: [
      fecha,
      plataforma,
      usuario_logueado,
      usuario_no_logueado,
      id_sesion,
      tiempo_sesion_time,
      fuente_medio_usuario,
      categoria_dispositivo,
      marca_dispositivo,
      sistema_operativo,
      modelo,
      estado,
      ciudad,
      pais
    ]
  }
}
