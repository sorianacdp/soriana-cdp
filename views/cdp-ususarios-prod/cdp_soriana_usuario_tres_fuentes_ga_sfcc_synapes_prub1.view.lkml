view: cdp_soriana_usuario_tres_fuentes_ga_sfcc_synapes_prub1 {
  derived_table: {
    sql: select distinct fecha,
        --sy.IdClienteSFCC as IdClienteSynapse,
     sy.correo as correoSynapse,
     ga.usuarioLogueado as usuarioLogueadoGA,
     sfcc.email as emailSFCC,
     sfcc.firstName as firstNameSFCC,
     sfcc.fatherName as fatherNameSFCC,
     sfcc.phoneMobile asphoneMobileSFCC,

      sy.Sexo as sexoSynapse,
      sy.FechaNacimiento as FechaNacimientoSynapse,

      ga.nombreCampana as nombreCampanaGA,
      ga.idTransaccion as idTransaccionGA,
      ga.idArticulo as idArticuloGA,
      ga.articulosComprados as articulosCompradosGA,
      ga.precioVenta as precioVentaGA,
      ga.cantidad as cantidadGA,
      ga.precioUnitario as precioUnitarioGA

      from `costumer-data-proyect.customer_data_platform.cdp-usuario_ articulos _ga_gads_fads_purchase` as ga
      left join `costumer-data-proyect.salesforce_commerce_cloud.stg_CustomerSalesforce`  as sfcc on (ga.usuarioLogueado=sfcc.customerId)
      left join `costumer-data-proyect.cdp_soriana_synapse.ClientesProd`  as sy on ( sfcc.email=sy.correo)

      where usuarioLogueado != '(not set)' and idTransaccion != '(not set)' and email is not null
      and sy.correo  is not null and sy.Sexo  is not null and sy.FechaNacimiento is not null

      order by fecha desc
      --limit 1000
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

  dimension: correo_synapse {
    type: string
    sql: ${TABLE}.correoSynapse ;;
  }

  dimension: usuario_logueado_ga {
    type: string
    sql: ${TABLE}.usuarioLogueadoGA ;;
  }

  dimension: email_sfcc {
    type: string
    sql: ${TABLE}.emailSFCC ;;
  }

  dimension: first_name_sfcc {
    type: string
    sql: ${TABLE}.firstNameSFCC ;;
  }

  dimension: father_name_sfcc {
    type: string
    sql: ${TABLE}.fatherNameSFCC ;;
  }

  dimension: asphone_mobile_sfcc {
    type: string
    sql: ${TABLE}.asphoneMobileSFCC ;;
  }

  dimension: sexo_synapse {
    type: string
    sql: ${TABLE}.sexoSynapse ;;
  }

  dimension: fecha_nacimiento_synapse {
    type: date
    datatype: date
    sql: ${TABLE}.FechaNacimientoSynapse ;;
  }

  dimension: nombre_campana_ga {
    type: string
    sql: ${TABLE}.nombreCampanaGA ;;
  }

  dimension: id_transaccion_ga {
    type: string
    sql: ${TABLE}.idTransaccionGA ;;
  }

  dimension: id_articulo_ga {
    type: string
    sql: ${TABLE}.idArticuloGA ;;
  }

  dimension: articulos_comprados_ga {
    type: string
    sql: ${TABLE}.articulosCompradosGA ;;
  }

  dimension: precio_venta_ga {
    type: number
    sql: ${TABLE}.precioVentaGA ;;
  }

  dimension: cantidad_ga {
    type: number
    sql: ${TABLE}.cantidadGA ;;
  }

  dimension: precio_unitario_ga {
    type: number
    sql: ${TABLE}.precioUnitarioGA ;;
  }

  set: detail {
    fields: [
      fecha,
      correo_synapse,
      usuario_logueado_ga,
      email_sfcc,
      first_name_sfcc,
      father_name_sfcc,
      asphone_mobile_sfcc,
      sexo_synapse,
      fecha_nacimiento_synapse,
      nombre_campana_ga,
      id_transaccion_ga,
      id_articulo_ga,
      articulos_comprados_ga,
      precio_venta_ga,
      cantidad_ga,
      precio_unitario_ga
    ]
  }
}
