view: cdpusuario__articulos__ga_gads_fads_view_item {
  sql_table_name: `costumer-data-proyect.customer_data_platform.cdp-usuario_ articulos _ga_gads_fads_view_item`
    ;;

  dimension: articulos_vistos {
    type: string
    sql: ${TABLE}.articulosVistos ;;
  }

  dimension: cantidad {
    type: number
    sql: ${TABLE}.cantidad ;;
  }

  dimension: categoria_articulo {
    type: string
    sql: ${TABLE}.categoriaArticulo ;;
  }

  dimension: clics_facebook_ads {
    type: string
    sql: ${TABLE}.clicsFacebookAds ;;
  }

  dimension: clics_google_ads {
    type: number
    sql: ${TABLE}.clicsGoogleAds ;;
  }

  dimension: conteo_articulos_vistos {
    type: number
    sql: ${TABLE}.conteoArticulosVistos ;;
  }

  dimension: conversiones {
    type: number
    sql: ${TABLE}.conversiones ;;
  }

  dimension: conversiones_facebook_ads {
    type: string
    sql: ${TABLE}.conversionesFacebookAds ;;
  }

  dimension: conversiones_google_ads {
    type: number
    sql: ${TABLE}.conversionesGoogleAds ;;
  }

  dimension: costo_facebook_ads {
    type: string
    sql: ${TABLE}.costoFacebookAds ;;
  }

  dimension: costo_google_ads {
    type: number
    sql: ${TABLE}.costoGoogleAds ;;
  }

  dimension: costo_por_conversion_facebook_ads {
    type: string
    sql: ${TABLE}.costoPorConversionFacebookAds ;;
  }

  dimension: costo_por_conversion_google_ads {
    type: number
    sql: ${TABLE}.costoPorConversionGoogleAds ;;
  }

  dimension_group: fecha {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.fecha ;;
  }

  dimension: fuente_medio_usuario {
    type: string
    sql: ${TABLE}.fuenteMedioUsuario ;;
  }

  dimension: hace_nsemana {
    type: number
    sql: ${TABLE}.haceNSemana ;;
  }

  dimension: id_articulo {
    type: string
    sql: ${TABLE}.idArticulo ;;
  }

  dimension: id_transaccion {
    type: string
    sql: ${TABLE}.idTransaccion ;;
  }

  dimension: impresiones_facebook_ads {
    type: string
    sql: ${TABLE}.impresionesFacebookAds ;;
  }

  dimension: impresiones_google_ads {
    type: number
    sql: ${TABLE}.impresionesGoogleAds ;;
  }

  dimension: ingreso_total {
    type: number
    sql: ${TABLE}.ingresoTotal ;;
  }

  dimension: marca_articulo {
    type: string
    sql: ${TABLE}.marcaArticulo ;;
  }

  dimension: nombre_campana {
    type: string
    sql: ${TABLE}.nombreCampana ;;
  }

  dimension: nombre_campana_facebook_ads {
    type: string
    sql: ${TABLE}.nombreCampanaFacebookAds ;;
  }

  dimension: nombre_campana_google_ads {
    type: string
    sql: ${TABLE}.nombreCampanaGoogleAds ;;
  }

  dimension: num_semana {
    type: number
    sql: ${TABLE}.numSemana ;;
  }

  dimension: plataforma {
    type: string
    sql: ${TABLE}.plataforma ;;
  }

  dimension: precio {
    type: number
    sql: ${TABLE}.precio ;;
  }

  dimension: usuario_logueado {
    type: string
    sql: ${TABLE}.usuarioLogueado ;;
  }

  dimension: variante_articulo {
    type: string
    sql: ${TABLE}.varianteArticulo ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
